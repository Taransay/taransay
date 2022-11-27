// Taransay switch
//
// Sean Leavey <electronics@attackllama.com>

#define FIRMWARE_VERSION "1.0.0"

// RFM69CW settings.
#define RF69_SPI_CS      10
#define RF69_IRQ_PIN     2
#define FREQUENCY        RF69_433MHZ
#define NODE_ID          23
#define BASE_ID          1
#define NETWORK_ID       1
#define MAX_BUFFER_LENGTH 61            // Limited by RFM69 library.
//#define ENABLE_ATC                    // Enable auto transmission control.

#include <avr/pgmspace.h>
#include <Taransay.h>
#include <Adafruit_WS2801.h>
#include <SPI.h>

// Command handling.
static uint16_t rf_dest;
static char rf_in_buf[MAX_BUFFER_LENGTH];
static char rf_out_buf[MAX_BUFFER_LENGTH];
static uint8_t rf_in_len;
static uint8_t rf_out_len;
static bool rf_ack;
static uint8_t rf_retries = 3;

// State.
typedef struct {
  bool switch1 = false;
  bool switch2 = false;
} State;

State state;
bool report_state = false;

// Button debouncing.
bool button1_triggered = false;
bool button2_triggered = false;

#ifdef ENABLE_ATC
  RFM69_ATC radio;
#else
  RFM69 radio;
#endif

static void print_help() {
  Serial.println(
    F(
      "; Available commands:\r\n"
      ";  STATE:<n>:<state> - set state of switch <n> to <state> ('ON' or 'OFF')\r\n"
      ";  NACK:<n>          - set number of ACK retries to <n>\r\n"
      ";  HELP              - print this help"
    )
  );
}

static void handle_serial() {
  static char input_line[MAX_BUFFER_LENGTH];
  static uint8_t input_pos = 0;
  char c = Serial.read();

  switch (c) {
    case '\r':  // Ignore carriage return.
      break;

    case '\n':
      if (!input_pos) {
        // Ignore empty lines.
        break;
      }

      input_line[input_pos] = '\0';  // Null terminate the string.
      parse_command(input_line);
      input_pos = 0;
      break;

    default:
      // Add the character to the line if it's not yet full, otherwise discard.
      if (input_pos < (MAX_BUFFER_LENGTH - 1)) {
        input_line[input_pos++] = c;
      }

      break;
  }
}

static void handle_rf_payload() {
  rf_in_buf[rf_in_len] = '\0';
  parse_command(rf_in_buf);
  rf_in_len = 0;
}

static void parse_command(char message[]) {
  char *token;

  // Begin parse.
  token = strtok(message, ":");
  Serial.print(F("> "));
  Serial.print(token);

  if (strcmp(token, "HELP") == 0) {
    Serial.println();
    print_help();

    // Successful parse.
    return;
  } else if (strcmp(token, "STATE") == 0) {
    // Set state.
    rf_ack = true;

    Serial.print(F(" "));
    token = strtok(null, ":");  // switch number
    Serial.print(token);

    uint8_t switch_ = atoi(token);

    Serial.print(F(" "));
    token = strtok(null, ":");  // switch state
    Serial.print(token);

    bool status;
    if (strcmp(token, "ON") == 0) {
      status = true;
    } else if (strcmp(token, "OFF") == 0) {
      status = false;
    } else {
      Serial.println();
      Serial.print(F("! invalid switch status '"));
      Serial.print(token);
      Serial.println(F("'"));
      return;
    }

    if (switch_ == 1) {
      state.switch1 = status;
    } else if (switch_ == 2) {
      state.switch2 = status;
    } else {
      Serial.println();
      Serial.print(F("! invalid switch number '"));
      Serial.print(switch_);
      Serial.println(F("'"));
      return;
    }

    Serial.println();

    // Successful parse.
    return;
  } else if (strcmp(token, "NACK") == 0) {
    Serial.print(F(" "));
    token = strtok(null, ":");
    rf_retries = atoi(token);
    Serial.println(token);

    if (rf_retries > 0) {
      Serial.print(F("number of ACK retries set to "));
      Serial.println(rf_retries);
    } else {
      Serial.println(F("! number of ACK retries must be > 0"));
    }

    // Successful parse.
    return;
  }

  Serial.println();
  Serial.print(F("; unrecognised command '"));
  Serial.print(token);
  Serial.println(F("'"));
}

void setup() {
  hardware_init();

  Serial.print(F("; Taransay switch v"));
  Serial.println(FIRMWARE_VERSION);
  Serial.println(F("; Sean Leavey <electronics@attackllama.com>"));

  delay(500);
  print_sensor_status();

  radio.initialize(FREQUENCY, NODE_ID, NETWORK_ID);

  Serial.println(F("; RFM69CW enabled: "));
  Serial.print(F(";   frequency: "));
  Serial.println(FREQUENCY == RF69_433MHZ ? "433" : FREQUENCY == RF69_868MHZ ? "868" : "915");
  Serial.print(F(";   node: "));
  Serial.println(NODE_ID);
  Serial.print(F(";   network: "));
  Serial.println(NETWORK_ID);
#ifdef ENABLE_ATC
  Serial.println(F(";   auto transmission control enabled"));
#endif

  // Disable unused pins, buses, etc.
  //hardware_disable();

  // Set up relays.
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  digitalWrite(3, LOW);
  digitalWrite(4, LOW);

  // Set external switches to tristate.
  pinMode(7, INPUT_PULLUP);
  pinMode(8, INPUT_PULLUP);

  Serial.println();
  print_help();
}

void loop() {
  if (Serial.available()) {
    handle_serial();
  }

  if (report_state && radio.canSend()) {
    rf_dest = BASE_ID;
    rf_out_buf[0] = '\0';
    strcat(rf_out_buf, "STATE:1:");
    if (state.switch1) {
      strcat(rf_out_buf, "ON");
    } else {
      strcat(rf_out_buf, "OFF");
    }
    strcat(rf_out_buf, ":2:");
    if (state.switch1) {
      strcat(rf_out_buf, "ON");
    } else {
      strcat(rf_out_buf, "OFF");
    }
    rf_out_len = strlen(rf_out_buf);

    Serial.print(F("send ["));
    Serial.print(rf_dest);
    Serial.print(F("] "));

    for (uint8_t i = 0; i < rf_out_len; i++) {
      Serial.print(rf_out_buf[i]);
    }

    if (rf_ack) {
      if (radio.sendWithRetry(rf_dest, rf_out_buf, rf_out_len, rf_retries)) {
        Serial.print(F(" [ACK success]"));
      } else {
        Serial.print(F(" [ACK failure]"));
      }
    } else {
      radio.send(rf_dest, rf_out_buf, rf_out_len);
    }

    Serial.println();
    rf_dest = 0;
    report_state = false;
  }

  if (radio.receiveDone()) {
    int16_t rssi = radio.RSSI;  // Copy as soon as possible after receive.
    bool ack_requested = radio.ACKRequested();

    // Copy received payload.
    memcpy(rf_in_buf, radio.DATA, radio.DATALEN);
    rf_in_len = radio.DATALEN;

    if (ack_requested) {
      radio.sendACK();
    }

    Serial.print(F("receive "));
    Serial.print(F("[from "));
    Serial.print(radio.SENDERID);
    Serial.print(F("] "));

    for (uint8_t i = 0; i < rf_in_len; i++) {
      if (rf_in_buf[i] == '\n' || rf_in_buf[i] == '\r') {
        // Remove newlines in the payload. This should only ever happen with
        // noisy data that actually made it through.
        rf_in_buf[i] = ' ';
      }

      Serial.print((char) rf_in_buf[i]);
    }

    Serial.print(F(" [RSSI "));
    Serial.print(rssi);
    Serial.print(F("]"));

    if (ack_requested) {
      Serial.print(F(" [ACK]"));
    }

    Serial.println();
    handle_rf_payload();
  }

  bool button1 = digitalRead(7);
  if (button1_triggered && button1) {
    // Fired button 1 transitioned back to HIGH.
    state.switch1 = !state.switch1;
    button1_triggered = false;
  } else {
    if (!button1) {
      // Initial firing. Button 1 is LOW.
      button1_triggered = true;
    }
  }

  bool button2 = digitalRead(8);
  if (button2_triggered && button2) {
    // Fired button 2 transitioned back to HIGH.
    state.switch2 = !state.switch2;
    button2_triggered = false;
  } else {
    if (!button2) {
      // Initial firing. Button 2 is LOW.
      button2_triggered = true;
    }
  }

  // Update state.
  if (digitalRead(3) != state.switch1) {
    digitalWrite(3, state.switch1);
    report_state = true;
  }
  if (digitalRead(4) != state.switch2) {
    digitalWrite(4, state.switch2);
    report_state = true;
  }
}
