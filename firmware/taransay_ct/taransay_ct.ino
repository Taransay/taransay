// Firmware version.
#define FIRMWARE_VERSION "1.0.1"

// Watchdog timeout (ms).
#define WDT_PERIOD            80
// Data sent after WDT_MAX_NUMBER periods of WDT_PERIOD ms without pulses:
// 60 x 80 ms = 4.8 s (~5 s once processed by emoncms).
#define WDT_MAX_NUMBER        60

// Set DS18B20 temperature precision. The higher the precision, the longer, and therefore
// more battery power, the conversion takes.
// 9 (93.8ms), 10 (187.5ms), 11 (375ms) or 12 (750ms) bits
// equal to resolution of 0.5 C, 0.25 C, 0.125 C and 0.0625 C.
#define DS18B20_PRECISION     11
#define ASYNC_DELAY           375

// RFM69CW settings.
#define NETWORK_NODE_ID       21  // 0-31
#define NETWORK_GROUP         210

#include <avr/power.h>
#include <avr/pgmspace.h>
#include <Taransay.h>
#include <EmonLib.h>

// Attach JeeLib sleep function to Atmega328 watchdog.
// This enables the microcontroller to be put into sleep mode in between readings to reduce power consumption.
ISR(WDT_vect) { Sleepy::watchdogEvent(); }

// Packet structure.
typedef struct {
  int supply_voltage;               // x1000
  int power;                        // x1
  int temperature;                  // x10
  int humidity;                     // x10
  int ext_temperature;              // x10
} PayloadTX;

PayloadTX taransay_ct;

// Watchdog timer count.
unsigned long WDT_number;

void setup() {
  delay(100);

  hardware_init(NETWORK_NODE_ID, NETWORK_GROUP);
  
  Serial.print(F("Taransay CT v")); Serial.println(FIRMWARE_VERSION);
  Serial.println(F("Sean Leavey <electronics@attackllama.com>"));
  Serial.println(F("Starting..."));

  delay(2000);
  serial_print_startup(NETWORK_NODE_ID, NETWORK_GROUP);

  // Initial watchdog count.
  WDT_number = 720;

  // Disable unused pins, buses, etc.
  hardware_disable();
  //if (debug==0) power_usart0_disable();   //disable serial UART
}

void loop()
{
  if (Sleepy::loseSomeTime(WDT_PERIOD)) {
    WDT_number++;
  }

  if (WDT_number < WDT_MAX_NUMBER) {
    return;
  }
  
  // Get supply voltage (x1000).
  if (battery_enabled) {
    battery_read();
  } else {
    battery_voltage = 0;
  }
  
  taransay_ct.supply_voltage = battery_voltage;

  // Read power.
  if (ct_enabled) {
    ct_read();
  } else {
    // Set power to zero.
    ct_power = 0;
  }
  
  taransay_ct.power = ct_power;

  // Read from SI7021 temperature and humidity sensor.
  if (si7021_enabled) {
    si7021_read();
    taransay_ct.temperature = int(si7021_temperature * 0.1);
    taransay_ct.humidity = int(si7021_humidity * 0.1);
  }

  // Get external temperature reading.
  if (ds18b20_enabled) {
    ds18b20_read();
  }
  
  // Copy temperature into payload.
  taransay_ct.ext_temperature = ds18b20_temperature;

  // Enable SPI bus for RF module.
  power_spi_enable();

  // Sleep until fully woken up.
  rf12_sleep(RF12_WAKEUP);
  dodelay(30);

  // Send payload.
  rf12_sendNow(0, &taransay_ct, sizeof taransay_ct);

  // Set the sync mode to 3 (full power down) then sleep.
  // NOTE: this requires the 258 CK fuse to be set.
  rf12_sendWait(3);
  rf12_sleep(RF12_SLEEP);
  dodelay(100);

  // Disable SPI bus.
  power_spi_disable();

  // Reset watchdog count.
  WDT_number = 0;
}
