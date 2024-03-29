// Taransay Base
//
// Sean Leavey <electronics@attackllama.com>

#define FIRMWARE_VERSION  "2.0.0"

// RFM69CW settings.
#define RF69_SPI_CS       10
#define RF69_IRQ_PIN      2
#define FREQUENCY         RF69_433MHZ
#define NODE_ID           1
#define NETWORK_ID        1
#define MAX_BUFFER_LENGTH 61            // Limited by RFM69 library.
//#define ENABLE_ATC                    // Enable auto transmission control.

#include <avr/pgmspace.h>
#include <Taransay.h>

// Command handling.
static uint16_t rf_dest;
static char rf_in_buf[MAX_BUFFER_LENGTH];
static char rf_out_buf[MAX_BUFFER_LENGTH];
static uint8_t rf_in_len;
static uint8_t rf_out_len;
static bool rf_ack;
static uint8_t rf_retries = 3;

#ifdef ENABLE_ATC
  RFM69_ATC radio;
#else
  RFM69 radio;
#endif

// Spy mode, allowing all packets on the same network to be sniffed.
bool spy = false;

static void print_help() {
  Serial.println(
    F(
      "; Available commands:\r\n"
      ";  TX:<n>:msg  - send msg to node <n>, no ack\r\n"
      ";  TXA:<n>:msg - send msg to node <n>, with ack\r\n"
      ";  NACK:<n>    - set number of ACK retries to <n>\r\n"
      ";  SPY         - toggle spy mode\r\n"
      ";  HELP        - print this help"
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

static void parse_command(char message[]) {
  char *token;

  // Begin parse.
  token = strtok(message, ":");
  Serial.print(F("> "));
  Serial.print(token);

  if (strcmp(token, "SPY") == 0) {
    Serial.println();
    spy = !spy;
    Serial.print(F("spy mode "));
    if (spy) {
      Serial.println(F("on"));
    } else {
      Serial.println(F("off"));
    }

    // Successful parse.
    return;
  } else if (strcmp(token, "HELP") == 0) {
    Serial.println();
    print_help();

    // Successful parse.
    return;
  } else if (strcmp(token, "TX") == 0 || strcmp(token, "TXA") == 0) {
    // Transmit something to a node.
    rf_ack = strcmp(token, "TXA") == 0;

    // The next value is the target node.
    Serial.print(F(" "));
    token = strtok(null, ":");
    Serial.print(token);
    rf_dest = atoi(token);

    // The rest is the payload.
    Serial.print(F(" "));
    token = strtok(null, "");
    Serial.println(token);

    // Copy the payload to the message buffer, avoiding the \0 character.
    strcpy(rf_out_buf, token);
    rf_out_len = strlen(rf_out_buf);

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

  Serial.print(F("; Taransay Base v"));
  Serial.println(FIRMWARE_VERSION);
  Serial.println(F("; Sean Leavey <electronics@attackllama.com>"));

  delay(500);
  print_sensor_status();

  radio.initialize(FREQUENCY, NODE_ID, NETWORK_ID);
  radio.spyMode(spy);

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
  hardware_disable();

  Serial.println();
  print_help();
}

void loop() {
  if (Serial.available()) {
    handle_serial();
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
    if (spy) {
      Serial.print(F(" to "));
      Serial.print(radio.TARGETID);
    }
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
  }

  if (rf_dest && radio.canSend()) {
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
  }
}
