// Taransay RGBW
//
// For SK6812 RGBW LEDs (e.g. Neopixel).
// Based on Adafruit Neopixel RGBWstrandtest example.
//
// Sean Leavey <electronics@attackllama.com>

#define FIRMWARE_VERSION "1.0.0"

// RFM69CW settings.
#define RF69_SPI_CS       10
#define RF69_IRQ_PIN      2
#define FREQUENCY         RF69_433MHZ
#define NODE_ID           6
#define BASE_ID           1
#define NETWORK_ID        1
#define MAX_BUFFER_LENGTH 61            // Limited by RFM69 library.
//#define ENABLE_ATC                    // Enable auto transmission control.

// LED strip settings.
#define LED_PIN        6
#define LED_COUNT      160
#define BRIGHTNESS     255
#define FOOTSWITCH_PIN A7

#include <avr/pgmspace.h>
#include <Taransay.h>
#include <Adafruit_NeoPixel.h>

Adafruit_NeoPixel strip = Adafruit_NeoPixel(LED_COUNT, LED_PIN, NEO_GRBW + NEO_KHZ800);

const uint8_t PROGMEM gamma8[] = {
    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   1,   1,   1,   1,
    1,   1,   1,   1,   1,   1,   1,   1,   1,   2,   2,   2,   2,   2,   2,   2,
    2,   3,   3,   3,   3,   3,   3,   3,   4,   4,   4,   4,   4,   5,   5,   5,
    5,   6,   6,   6,   6,   7,   7,   7,   7,   8,   8,   8,   9,   9,   9,  10,
   10,  10,  11,  11,  11,  12,  12,  13,  13,  13,  14,  14,  15,  15,  16,  16,
   17,  17,  18,  18,  19,  19,  20,  20,  21,  21,  22,  22,  23,  24,  24,  25,
   25,  26,  27,  27,  28,  29,  29,  30,  31,  32,  32,  33,  34,  35,  35,  36,
   37,  38,  39,  39,  40,  41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  50,
   51,  52,  54,  55,  56,  57,  58,  59,  60,  61,  62,  63,  64,  66,  67,  68,
   69,  70,  72,  73,  74,  75,  77,  78,  79,  81,  82,  83,  85,  86,  87,  89,
   90,  92,  93,  95,  96,  98,  99, 101, 102, 104, 105, 107, 109, 110, 112, 114,
  115, 117, 119, 120, 122, 124, 126, 127, 129, 131, 133, 135, 137, 138, 140, 142,
  144, 146, 148, 150, 152, 154, 156, 158, 160, 162, 164, 167, 169, 171, 173, 175,
  177, 180, 182, 184, 186, 189, 191, 193, 196, 198, 200, 203, 205, 208, 210, 213,
  215, 218, 220, 223, 225, 228, 231, 233, 236, 239, 241, 244, 247, 249, 252, 255
};

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
  bool on = true;
  uint8_t red = 0;
  uint8_t green = 0;
  uint8_t blue = 0;
  uint8_t white = 255;
} State;

State state;
bool update_strip = false;
bool report_state = false;

// Button debouncing.
bool button_triggered = false;

#ifdef ENABLE_ATC
  RFM69_ATC radio;
#else
  RFM69 radio;
#endif

static void print_help() {
  Serial.println(
    F(
      "; Available commands:\r\n"
      ";  STATE:<state>[:RGBW:<r>,<g>,<b>,<w>] - set state to <state> and RGBW to <r>, <g>, <b>, <w>\r\n"
      ";  NACK:<n>                             - set number of ACK retries to <n>\r\n"
      ";  HELP                                 - print this help"
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
    token = strtok(null, ":");  // state
    Serial.print(token);
    state.on = strcmp(token, "ON") == 0;

    Serial.print(F(" "));
    token = strtok(null, ":");
    Serial.print(token);

    if (strcmp(token, "RGBW") == 0) {
      Serial.print(F(" "));
      token = strtok(null, ",");  // R
      Serial.print(token);
      state.red = atoi(token);

      Serial.print(F(","));
      token = strtok(null, ",");  // G
      Serial.print(token);
      state.green = atoi(token);

      Serial.print(F(","));
      token = strtok(null, ",");  // B
      Serial.print(token);
      state.blue = atoi(token);

      Serial.print(F(","));
      token = strtok(null, ",");  // W
      Serial.print(token);
      state.white = atoi(token);
    }

    Serial.println();
    update_strip = true;

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

  // Set external switch to tristate.
  pinMode(FOOTSWITCH_PIN, INPUT_PULLUP);

  Serial.print(F("; Taransay RGB v"));
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

  strip.begin();
  strip.show();  // Update LED contents. To start with, they are all set to off.
  strip.setBrightness(BRIGHTNESS);

  Serial.println();
  print_help();
}

void loop() {
  if (Serial.available()) {
    handle_serial();
  }

  if (report_state && radio.canSend()) {
    static char rstr[4];
    static char gstr[4];
    static char bstr[4];
    static char wstr[4];

    itoa(state.red, rstr, 10);
    itoa(state.green, gstr, 10);
    itoa(state.blue, bstr, 10);
    itoa(state.white, wstr, 10);

    rf_dest = BASE_ID;
    rf_out_buf[0] = '\0';
    strcat(rf_out_buf, "STATE:");
    if (state.on) {
      strcat(rf_out_buf, "ON");
    } else {
      strcat(rf_out_buf, "OFF");
    }
    strcat(rf_out_buf, ":RGBW:");
    strcat(rf_out_buf, rstr);
    strcat(rf_out_buf, ",");
    strcat(rf_out_buf, gstr);
    strcat(rf_out_buf, ",");
    strcat(rf_out_buf, bstr);
    strcat(rf_out_buf, ",");
    strcat(rf_out_buf, wstr);
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

  bool button = analogRead(FOOTSWITCH_PIN) > 800;  // For some reason digitalRead doesn't detect LOW properly.
  if (button_triggered && button) {
    // Fired button transitioned back to HIGH.
    if (state.on) {
      state.on = false;
    } else {
      // Reset to default on state.
      state = State();
    }

    button_triggered = false;
    update_strip = true;
  } else {
    if (!button) {
      // Initial firing. Button is LOW.
      button_triggered = true;
    }
  }

  if (update_strip) {
    Serial.println("; updating strip");

    // Apply gamma correction.
    uint8_t red = gamma(state.red);
    uint8_t green = gamma(state.green);
    uint8_t blue = gamma(state.blue);
    uint8_t white = gamma(state.white);

    Serial.print("; R: ");
    Serial.print(red);
    Serial.print(" G: ");
    Serial.print(green);
    Serial.print(" B: ");
    Serial.println(blue);
    Serial.print(" W: ");
    Serial.println(white);

    if (!state.on) {
      red = 0;
      green = 0;
      blue = 0;
      white = 0;
    }

    for (uint8_t i = 0; i < strip.numPixels(); i++) {
      strip.setPixelColor(i, red, green, blue, white);
    }

    strip.show();

    update_strip = false;
    report_state = true;
  }
}

uint8_t gamma(uint8_t value) {
  return pgm_read_byte(&gamma8[value]);
}
