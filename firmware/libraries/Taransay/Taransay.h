#ifndef taransay_h
#define taransay_h

// Hardware connections.
#define SUPPLY_MONITOR_PIN    A7
#define LED_PIN               6
#define CURRENT_TRANSDUCER_PIN A1
#define ONE_WIRE_BUS          A2 // DS18B20 data
#define ONE_WIRE_POWER        A3 // DS18B20 power

// Flag compatibility with emonTx v3.
#define emonTxV3

// RFM69CW/RFM12B compatibility mode.
#ifndef RF69_COMPAT
  #define RF69_COMPAT         1
#endif

// Serial data rate.
#ifndef BAUD_RATE
  #define BAUD_RATE           38400
#endif

// Voltage used for apparent power measurement.
#ifndef VOLTAGE_RMS
  #define VOLTAGE_RMS         230
#endif

// Number of samples to make.
#ifndef VOLTAGE_SAMPLES
  #define VOLTAGE_SAMPLES     1662
#endif

// Current calibration: (2000 turns / 22 ohm burden resistance).
#ifndef CURRENT_CALIBRATION
  #define CURRENT_CALIBRATION 90.9
#endif

// DS18B20 temperature precision: 9 (93.8ms), 10 (187.5ms), 11 (375ms) or 12 (750ms) bits
// equal to resolution of 0.5 C, 0.25 C, 0.125 C and 0.0625 C.
#ifndef DS18B20_PRECISION
  #define DS18B20_PRECISION   12
#endif

// Default temperature reading for when reading is out of range of sensor is not present.
#define DS18B20_DEFAULT       -55

// Delay required to take temperature measurement (see above).
#ifndef ASYNC_DELAY
  #define ASYNC_DELAY         750
#endif

#include <Arduino.h>
#include <JeeLib.h>
#include <OneWire.h> // OneWire protocol library.
#include <DallasTemperature.h> // DS18B20 temperature sensor library.
#include <Wire.h> // I2C protocol library.
#include <SI7021.h> // Si7021 temperature and humidity sensor library.
#include <EmonLib.h>

// Detected hardware flags.
extern bool ct_enabled;
extern bool ds18b20_enabled;
extern bool si7021_enabled;

// Current transducer.
extern EnergyMonitor ct;
extern int ct_power;

// Setup DS18B20 temperature sensor.
extern OneWire one_wire;
extern DallasTemperature sensors;
extern byte ds18b20_address[8];  // 8 bytes per address
extern int ds18b20_temperature;

// Setup SI7021 temperature and humidity sensor.
extern SI7021 si7021;
extern int si7021_device_id;
extern int si7021_temperature, si7021_humidity;

void hardware_init(unsigned int, unsigned int);
void hardware_disable(void);
void led_flash(unsigned int, unsigned int);
void ct_init(void);
void ct_read(void);
void ds18b20_init(void);
void ds18b20_read(void);
void ds18b20_on(void);
void ds18b20_off(void);
void si7021_init(void);
void si7021_read(void);
void rf_setup(unsigned int, unsigned int);
bool rf_rx_handle(void);
void rf_send(void);
void print_frame(int);
void serial_print_startup(unsigned int, unsigned int);
void dodelay(unsigned int);

#endif
