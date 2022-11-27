#include "Taransay.h"
#include <avr/pgmspace.h>
#include <avr/power.h>
#include <util/delay.h>

bool battery_enabled;
bool ct_enabled;
bool ds18b20_enabled;
bool si7021_enabled;

EnergyMonitor ct;
int ct_power;

int battery_voltage;

byte ds18b20_address[8];  // 8 bytes per address
unsigned int ds18b20_count;
int ds18b20_temperature;

OneWire one_wire(ONE_WIRE_BUS);
DallasTemperature sensors(&one_wire);

SI7021 si7021;
int si7021_device_id;
int si7021_temperature, si7021_humidity;

void hardware_init() {
  // Set up LED pin and switch on.
  pinMode(LED_PIN, OUTPUT);
  led_on();

  // Set up serial.
  Serial.begin(BAUD_RATE);
  _delay_ms(100);

  Serial.print(F("; Starting..."));

  // Set up battery monitor.
  battery_init();
  _delay_ms(100);

  // Detect current transducer.
  ct_init();
  _delay_ms(100);

  // Detect DS18B20 sensor(s).
  ds18b20_init();
  _delay_ms(100);

  // Detect Si7021 sensor.
  si7021_init();
  _delay_ms(100);

  Serial.println(F(" done"));

  // Switch off LED.
  led_off();
}

void hardware_disable() {
  // Set unused pins to pullup to decrease power consumption.
  // https://electronics.stackexchange.com/questions/43460/how-should-unused-i-o-pins-be-configured-on-atmega328p-for-lowest-power-consumpt
  pinMode(5, INPUT_PULLUP);
  pinMode(7, INPUT_PULLUP);
  pinMode(8, INPUT_PULLUP);
  pinMode(9, INPUT_PULLUP);
  pinMode(A0, INPUT_PULLUP);
  pinMode(A6, INPUT_PULLUP);

  // FIXME: RF AND PULSE IRQ - DISABLE ONLY IF NO PULSE DETECTION ENABLED
  //pinMode(2, INPUT_PULLUP);
  pinMode(3, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);

  // Disable analog comparator.
  ACSR |= (1 << ACD);
  // Disable I2C bus power.
  power_twi_disable();
  // Disable second timer.
  power_timer1_disable();
}

void led_on() {
  digitalWrite(LED_PIN, HIGH);
}

void led_off() {
  digitalWrite(LED_PIN, LOW);
}

void led_flash(uint8_t count, uint8_t duration) {
  for (uint8_t i = 0; i < count; i++) {
    led_on();
    delay(duration);
    led_off();
  }
}

void battery_init() {
  pinMode(SUPPLY_MONITOR_PIN, INPUT);

  // Use the analog supply rail as the reference.
  analogReference(DEFAULT);

  // Make a throwaway measurement.
  analogRead(SUPPLY_MONITOR_PIN);

  // Check for volage on the battery monitor.
  battery_enabled = analogRead(SUPPLY_MONITOR_PIN) > 0;
}

void battery_read() {
  battery_voltage = BATTERY_CALIBRATION * map(analogRead(SUPPLY_MONITOR_PIN), 0, 1023, 0, 3300);
}

void ct_init() {
  // Set up current transducer.
  pinMode(CURRENT_TRANSDUCER_PIN, INPUT);

  // Check for voltage on the input (should be roughly half the supply).
  ct_enabled = analogRead(CURRENT_TRANSDUCER_PIN) > 0;

  // Set calibration.
  ct.current(CURRENT_TRANSDUCER_PIN, CURRENT_CALIBRATION);
}

void ct_read() {
  ct_power = ct.calcIrms(VOLTAGE_SAMPLES) * VOLTAGE_RMS;
}

void ds18b20_init() {
  // Set up DS18B20 sensor power.
  pinMode(ONE_WIRE_POWER, OUTPUT);
  digitalWrite(ONE_WIRE_POWER, LOW);

  ds18b20_on();

  sensors.begin();
  // Disable automatic temperature conversion to reduce time spent awake,
  // instead conversion will be implemented manually in sleeping.
  // See http://harizanov.com/2013/07/optimizing-ds18b20-code-for-low-power-applications/.
  sensors.setWaitForConversion(false);

  ds18b20_count = sensors.getDeviceCount();

  if (ds18b20_count > 0) {
    ds18b20_enabled = true;

    // Get address.
    one_wire.search(ds18b20_address);
  } else {
    // Set default value.
    ds18b20_temperature = DS18B20_DEFAULT * 10.0;
  }

  ds18b20_off();
}

void ds18b20_read() {
  // Power on the sensor.
  ds18b20_on();

  // Set the conversion resolution.
  sensors.setResolution(ds18b20_address, DS18B20_PRECISION);

  // Measure temperature.
  sensors.requestTemperatures();

  // Wait for temperature measurement.
  dodelay(ASYNC_DELAY);

  // Get temperature.
  float temperature = sensors.getTempC(ds18b20_address);

  // Power off the sensor.
  ds18b20_off();

  // Check if reading is within range.
  if ((temperature > 125.0) || (temperature < -55.0)) {
    // Out of range; set to default.
    temperature = DS18B20_DEFAULT;
  }

  // Convert to integer representing tenths of a degree.
  // (float -> int conversion)
  ds18b20_temperature = temperature * 10.0;
}

void ds18b20_on() {
  // Turn on sensor power and wait.
  digitalWrite(ONE_WIRE_POWER, HIGH);
  dodelay(50);
}

void ds18b20_off() {
  // Turn off sensor power.
  digitalWrite(ONE_WIRE_POWER, LOW);
}

void si7021_init() {
  // Power up I2C bus.
  power_twi_enable();

  // Check if the I2C lines are HIGH.
  if (! (digitalRead(SDA) == HIGH || digitalRead(SCL) == HIGH)) {
    si7021_enabled = false;
    return;
  }

  si7021.begin();
  si7021_device_id = si7021.getDeviceId();

  // Power down I2C bus.
  power_twi_disable();

  // Check if the device ID is a recognised one.
  if (si7021_device_id != 0x0D && si7021_device_id != 0x14 && si7021_device_id != 0x15) {
    si7021_enabled = false;
    return;
  }

  si7021_enabled = true;
}

void si7021_read() {
  // Power up I2C bus.
  power_twi_enable();

  // Get readings.
  si7021_env data = si7021.getHumidityAndTemperature();

  // Power down I2C bus.
  power_twi_disable();

  // Read data.
  si7021_temperature = data.celsiusHundredths;
  si7021_humidity = data.humidityBasisPoints;
}

void print_sensor_status() {
  Serial.println(F("; Device status:"));

  if (battery_enabled) {
    Serial.print(F(";   Running on battery "));
    battery_read();
    Serial.print(F("("));
    Serial.print(battery_voltage);
    Serial.println(F(")"));
  } else {
    Serial.println(F(";   Running on external supply"));
  }

  Serial.print(F(";   Current transducer "));

  if (ct_enabled) {
    Serial.println(F("detected"));
  } else {
    Serial.println(F("not detected"));
  }

  Serial.print(F(";   "));
  Serial.print(ds18b20_count);
  Serial.println(F(" DS18B20 sensor(s) detected (only first used)"));

  if (ds18b20_count) {
    for (int i; i < 8; i++) {
        Serial.print(F(";   "));
        Serial.print(i);
        Serial.print(F(" address: "));
        Serial.println(ds18b20_address[i], HEX);
    }
  }

  if (si7021_enabled) {
    Serial.print(F(";   SI7021 detected "));
    Serial.print(F("("));
    Serial.print(si7021_device_id);
    Serial.println(F(")"));

    // Get first reading.
    si7021_read();
    Serial.print(F(";     t: "));
    Serial.println(si7021_temperature / 100.0);
    Serial.print(F(";     h: "));
    Serial.println(si7021_humidity / 100.0);
  } else {
    Serial.print(F(";   SI7021 not detected or invalid device ID "));
    Serial.print(F("("));
    Serial.print(si7021_device_id);
    Serial.println(F(")"));
  }
}

void dodelay(uint16_t period) {
  // Back up ADC state.
  byte old_ADCSRA = ADCSRA;
  byte old_ADCSRB = ADCSRB;
  byte old_ADMUX = ADMUX;

  // Enter low power mode for specified time (ms), valid range 16-65000 ms.
  //Sleepy::loseSomeTime(period);
  delay(period);

  // Restore ADC state.
  ADCSRA = old_ADCSRA;
  ADCSRB = old_ADCSRB;
  ADMUX = old_ADMUX;
}
