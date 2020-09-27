// Firmware version.
#define FIRMWARE_VERSION "1.1.0"

// Time between readings (ms).
#define SAMPLE_RATE           30000

// Time between RF resets (keeps RFM60CW alive, which is sometimes needed).
#define RF_RESET_PERIOD       60000

// RFM69CW settings.
#define NETWORK_NODE_ID       5   // 0-31
#define NETWORK_GROUP         210

#include <avr/pgmspace.h>
#include <Taransay.h>

// Attach JeeLib sleep function to Atmega328 watchdog.
// This enables the microcontroller to be put into sleep mode in between readings to reduce power consumption.
ISR(WDT_vect) { Sleepy::watchdogEvent(); }

// Packet structure.
typedef struct {
  int supply_voltage;               // x1000
  int temperature;                  // x10
  int humidity;                     // x10
  int ext_temperature;              // x10
} PayloadTX;

PayloadTX taransay_base;

// Last sample time.
unsigned long last_sample = 0;
// Current time.
unsigned long now = 0;
// Last RF reset time.
unsigned long last_rf_reset = 0;

void setup() {
  delay(100);

  hardware_init(NETWORK_NODE_ID, NETWORK_GROUP);
  
  Serial.print(F("; Taransay Base v")); Serial.println(FIRMWARE_VERSION);
  Serial.println(F("; Sean Leavey <electronics@attackllama.com>"));
  Serial.println(F("; Starting..."));

  delay(2000);
  serial_print_startup(NETWORK_NODE_ID, NETWORK_GROUP);

  // Disable unused pins, buses, etc.
  hardware_disable();
}

void loop()
{
  now = millis();

  // Check if RF packet has been received.
  if (rf_rx_handle()) {
    // Double LED flash to indicate data received.
    led_flash(2, 25);
  }

  // Transmit data packets if needed.
  rf_send();

  // Check if now has overflowed.
  if (now < last_sample || now < last_rf_reset) {
    // Assume now has overflowed, so reset variables that are checked against now.
    last_rf_reset = 0;
    last_sample = 0;
  }

  // Check if it's time to reset the RF module.
  if ((now - last_rf_reset) > RF_RESET_PERIOD) {
    Serial.println(F("; Resetting RF"));
    rf_setup(NETWORK_NODE_ID, NETWORK_GROUP);
    last_rf_reset = now;
  }

  // Check if it's time for the next sample.
  if ((now - last_sample) > SAMPLE_RATE) {
    // Single LED flash indicating local sensor sample.
    led_flash(1, 50);

    // Get supply voltage (x1000).
    if (battery_enabled) {
      battery_read();
    } else {
      battery_voltage = 0;
    }
  
    taransay_base.supply_voltage = battery_voltage;

    // Read from SI7021 temperature and humidity sensor.
    if (si7021_enabled) {
      si7021_read();
      taransay_base.temperature = int(si7021_temperature * 0.1);
      taransay_base.humidity = int(si7021_humidity * 0.1);
    }

    // Get external temperature reading.
    if (ds18b20_enabled) {
      ds18b20_read();
      // Copy temperature into payload.
      taransay_base.ext_temperature = ds18b20_temperature;
    }

    // Send packet to Raspberry Pi serial.
    send_rpi_serial(NETWORK_NODE_ID);

    // Update sample time.
    last_sample = now;
  }
}

// Send data to Pi serial /dev/ttyAMA0 using struct JeeLabs RF12 packet structure
void send_rpi_serial(unsigned int node_id) {
  byte binarray[sizeof(taransay_base)];
  memcpy(binarray, &taransay_base, sizeof(taransay_base));

  Serial.print(F("OK "));
  Serial.print(node_id);
  
  for (byte i = 0; i < sizeof(binarray); i++) {
    Serial.print(F(" "));
    Serial.print(binarray[i]);
  }
  
  Serial.print(F(" (-0)"));
  Serial.println();

  delay(10);
}
