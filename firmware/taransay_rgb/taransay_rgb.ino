// Taransay RGB
//
// Sean Leavey <electronics@attackllama.com>

#define FIRMWARE_VERSION "1.1.0"

// RFM69CW settings.
#define RF69_SPI_CS       10
#define RF69_IRQ_PIN      2
#define FREQUENCY         RF69_433MHZ
#define NODE_ID           5
#define BASE_ID           1
#define NETWORK_ID        1
#define MAX_BUFFER_LENGTH 61            // Limited by RFM69 library.
//#define ENABLE_ATC                    // Enable auto transmission control.

// LED strip settings.
#define LED_DATA_PIN      8
#define LED_CLOCK_PIN     9
#define NUM_LEDS          68

#include <avr/pgmspace.h>
#include <Taransay.h>
#include <FastLED.h>
#include <SPI.h>

CRGB strip[NUM_LEDS];

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
  bool on;
  uint8_t red = 255;
  uint8_t green = 255;
  uint8_t blue = 255;
  uint8_t brightness = 0;
} State;

State state;
bool update_strip = false;
bool report_state = false;

#ifdef ENABLE_ATC
  RFM69_ATC radio;
#else
  RFM69 radio;
#endif

static void print_help() {
  Serial.println(
    F(
      "; Available commands:\r\n"
      ";  STATE:<state>[:RGB:<r>,<g>,<b>[:B:<w>] - set state to <state> and RGBW to <r>, <g>, <b>, <w>\r\n"
      ";  NACK:<n>                               - set number of ACK retries to <n>\r\n"
      ";  HELP                                   - print this help"
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

    if (strcmp(token, "RGB") == 0) {
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
    }

    if (strcmp(token, "W") == 0) {
      Serial.print(F(" "));
      token = strtok(null, ",");  // W
      Serial.print(token);
      state.brightness = atoi(token);
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
  FastLED.addLeds<WS2801, LED_DATA_PIN, LED_CLOCK_PIN>(strip, NUM_LEDS);

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

  fill_solid(strip, NUM_LEDS, CRGB::Black);
  FastLED.setBrightness(255);  // Ensure dithering is off to begin with.
  FastLED.show();

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
    itoa(state.brightness, wstr, 10);

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

  if (update_strip) {
    Serial.println("; updating strip");

    // Apply gamma correction.
    uint8_t red = gamma(state.red);
    uint8_t green = gamma(state.green);
    uint8_t blue = gamma(state.blue);

    Serial.print("; R: ");
    Serial.print(red);
    Serial.print(" G: ");
    Serial.print(green);
    Serial.print(" B: ");
    Serial.println(blue);
    Serial.print(" X: ");
    Serial.println(state.brightness);

    if (!state.on) {
      red = 0;
      green = 0;
      blue = 0;
    }

    fill_solid(strip, NUM_LEDS, CRGB(red, green, blue));
    FastLED.setBrightness(state.brightness);

    update_strip = false;
    report_state = true;
  }

  // Calling this frequently, even if the LEDs haven't changed, allows temporal
  // dithering to update LED values.
  FastLED.show();
}

uint8_t gamma(uint8_t value) {
  return pgm_read_byte(&gamma8[value]);
}
