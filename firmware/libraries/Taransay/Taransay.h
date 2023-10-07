/**
 * Taransay library
 *
 * Functions for reading Taransay board sensors.
 *
 * Sean Leavey
 * <electronics@attackllama.com>
 */

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

// Serial data rate.
extern const int BAUD_RATE;

// Battery calibration.
extern const int BATTERY_CALIBRATION;

// Voltage used for apparent power measurement.
extern const int VOLTAGE_RMS;

// Number of samples to make.
extern const int VOLTAGE_SAMPLES;

// Current calibration.
extern const int CURRENT_CALIBRATION;

// DS18B20 temperature precision: 9 (93.8ms), 10 (187.5ms), 11 (375ms) or 12 (750ms) bits
// equal to resolution of 0.5 C, 0.25 C, 0.125 C and 0.0625 C.
extern const int DS18B20_PRECISION;

// Delay required to take temperature measurement (see above).
extern const int ASYNC_DELAY;

// Default temperature reading for when reading is out of range of sensor is not present.
#define DS18B20_DEFAULT       -55

#include <avr/wdt.h>
#include <Arduino.h>
#include <RFM69.h>
#include <RFM69_ATC.h>
#include <OneWire.h> // OneWire protocol library.
#include <DallasTemperature.h> // DS18B20 temperature sensor library.
#include <Wire.h> // I2C protocol library.
#include <SI7021.h> // Si7021 temperature and humidity sensor library.
#include <EmonLib.h>
#include <LowPower.h>

// Detected hardware flags.
extern bool battery_enabled;
extern bool ct_enabled;
extern bool ds18b20_enabled;
extern bool si7021_enabled;

// Current transducer.
extern EnergyMonitor ct;
extern int ct_power;

extern int battery_voltage;

// Setup DS18B20 temperature sensor.
extern OneWire one_wire;
extern DallasTemperature sensors;
extern byte ds18b20_address[8];  // 8 bytes per address
extern int ds18b20_temperature;

// Setup SI7021 temperature and humidity sensor.
extern SI7021 si7021;
extern int si7021_device_id;
extern int si7021_temperature, si7021_humidity;

extern uint8_t frequency;
extern uint16_t node_id;
extern uint8_t network_id;
extern bool spy;

#ifdef ENABLE_ATC
extern RFM69_ATC radio;
#else
extern RFM69 radio;
#endif

void hardware_init();
void hardware_disable(void);
void led_on();
void led_off();
void led_flash(uint8_t, uint8_t);
void battery_init(void);
void battery_read(void);
void ct_init(void);
void ct_read(void);
void ds18b20_init(void);
void ds18b20_read(void);
void ds18b20_on(void);
void ds18b20_off(void);
void si7021_init(void);
void si7021_read(void);
void print_sensor_status();
void dodelay(uint16_t);

#endif
