#define FIRMWARE_VERSION "1.1.0"

// Set DS18B20 temperature precision. The higher the precision, the longer, and therefore
// more battery power, the conversion takes.
// 9 (93.8ms), 10 (187.5ms), 11 (375ms) or 12 (750ms) bits
// equal to resolution of 0.5 C, 0.25 C, 0.125 C and 0.0625 C.
#define DS18B20_PRECISION     11
#define ASYNC_DELAY           375

// RFM69CW settings.
#define RF69_SPI_CS         10
#define RF69_IRQ_PIN        2
#define FREQUENCY           RF69_433MHZ
#define NODE_ID             26
#define BASE_ID             1
#define NETWORK_ID          1
#define MAX_BUFFER_LENGTH   61                   // Limited by RFM69 library.
#define ENABLE_ATC                               // Enable auto transmission control.

#include <avr/power.h>
#include <avr/pgmspace.h>
#include <LowPower.h>
#include <Taransay.h>
#include <EmonLib.h>

// Watchdog timeout.
#define WDT_PERIOD            SLEEP_8S
// State updated after WDT_MAX_NUMBER periods of WDT_PERIOD.
#define WDT_MAX_NUMBER        37  // approx. 5 mins

// Watchdog timer count.
uint16_t WDT_number = 0;

// Command handling.
static uint16_t rf_dest;
static char rf_out_buf[MAX_BUFFER_LENGTH];
static uint8_t rf_out_len;
static bool rf_ack = true;
static uint8_t rf_retries = 3;

// State structure.
typedef struct {
  int16_t supply_voltage;               // x1000
  int16_t temperature;                  // x10
  int16_t ext_temperature;              // x10
  int16_t humidity;                     // x10
} State;

State state;
bool report_state;

#ifdef ENABLE_ATC
  RFM69_ATC radio;
#else
  RFM69 radio;
#endif

void setup() {
  hardware_init();

  Serial.print(F("; Taransay TH v"));
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
  hardware_disable();

  // Let sensors settle then make a measurement.
  delay(2000);
  report_state = true;
}

void loop() {
  if (report_state) {
    static char vstr[6];
    static char t1str[6];
    static char t2str[6];
    static char hstr[6];

    // Get supply voltage.
    if (battery_enabled) {
      battery_read();
    } else {
      battery_voltage = 0;
    }

    state.supply_voltage = battery_voltage;

    // Read from SI7021 temperature and humidity sensor.
    if (si7021_enabled) {
      si7021_read();
      state.temperature = si7021_temperature;
      state.humidity = si7021_humidity;
    }

    // Get external temperature reading.
    if (ds18b20_enabled) {
      ds18b20_read();
    }

    // Copy temperature into payload.
    state.ext_temperature = ds18b20_temperature;

    ////////////////
    // Send data. //
    ////////////////

    rf_dest = BASE_ID;
    rf_out_buf[0] = '\0';

    strcat(rf_out_buf, "STATE:");

    itoa(state.supply_voltage, vstr, 10);
    itoa(state.temperature, t1str, 10);
    itoa(state.ext_temperature, t2str, 10);
    itoa(state.humidity, hstr, 10);

    strcat(rf_out_buf, "V:");
    strcat(rf_out_buf, vstr);
    strcat(rf_out_buf, ":T1:");
    strcat(rf_out_buf, t1str);
    strcat(rf_out_buf, ":T2:");
    strcat(rf_out_buf, t2str);
    strcat(rf_out_buf, ":H:");
    strcat(rf_out_buf, hstr);

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

    delay(100);  // Allow message to send before sleeping.
    radio.sleep();
  }

  LowPower.idle(
    WDT_PERIOD,
    ADC_OFF,
    TIMER2_OFF,
    TIMER1_OFF,
    TIMER0_OFF,
    SPI_OFF,
    USART0_OFF,
    TWI_OFF
  );

  WDT_number++;

  if (WDT_number < WDT_MAX_NUMBER) {
    return;
  }

  // Reset watchdog count.
  WDT_number = 0;

  report_state = true;
}
