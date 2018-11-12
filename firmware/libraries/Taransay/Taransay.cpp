#include "Taransay.h"
#include <avr/pgmspace.h>
#include <avr/power.h>

bool ct_enabled;
bool ds18b20_enabled;
bool si7021_enabled;

EnergyMonitor ct;
int ct_power;

byte ds18b20_address[8];  // 8 bytes per address
unsigned int ds18b20_count;
int ds18b20_temperature;

OneWire one_wire(ONE_WIRE_BUS);
DallasTemperature sensors(&one_wire);

SI7021 si7021;
int si7021_device_id;
int si7021_temperature, si7021_humidity;

// RF variables.
static byte stack[RF12_MAXDATA + 4];
static byte dest;
static char cmd;

void hardware_init(unsigned int node_id, unsigned int network_group) {
  // Set up LED pin and switch on.
  pinMode(LED_PIN, OUTPUT);
  digitalWrite(LED_PIN, HIGH);

  // Set up current transducer.
  pinMode(CURRENT_TRANSDUCER_PIN, INPUT);
  
  // Set up DS18B20 sensor power.
  pinMode(ONE_WIRE_POWER, OUTPUT);
  digitalWrite(ONE_WIRE_POWER, LOW);

  // Set up battery monitor.
  pinMode(SUPPLY_MONITOR_PIN, INPUT);
  
  // Set up serial.
  Serial.begin(BAUD_RATE);
  
  // Detect current transducer.
  ct_init();

  // Detect DS18B20 sensor(s).
  ds18b20_init();
  
  // Detect Si7021 sensor.
  si7021_init();
  
  // Set up RF module.
  rf_setup(node_id, network_group);
  
  // Switch off LED.
  digitalWrite(LED_PIN, LOW);
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

void led_flash(unsigned int count, unsigned int duration) {
  for (unsigned int i = 0; i < count; i++) {
    digitalWrite(LED_PIN, HIGH);
    delay(duration);
    digitalWrite(LED_PIN, LOW);
  }
}

void ct_init() {
  // Check for voltage on the input (should be roughly half the supply).
  ct_enabled = (analogRead(CURRENT_TRANSDUCER_PIN) > 0);
  
  // Set calibration.
  ct.current(CURRENT_TRANSDUCER_PIN, CURRENT_CALIBRATION);
}

void ct_read() {
  ct_power = ct.calcIrms(VOLTAGE_SAMPLES) * VOLTAGE_RMS;
}

void ds18b20_init() {
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

void serial_print_startup(unsigned int node_id, unsigned int network_group) {
  Serial.print(F("Current transducer "));
  
  if (ct_enabled) {
    Serial.println(F("enabled"));
  } else {
    Serial.println(F("disabled"));
  }
  
  Serial.print(F("Detected "));
  Serial.print(ds18b20_count);
  Serial.println(F(" DS18B20 sensors (only first used)"));
  Serial.print("Address:");
  for (int i; i < 8; i++) {
    Serial.print(" ");
    Serial.print(ds18b20_address[i], HEX);
  }
  Serial.println();

  if (si7021_enabled) {
    Serial.print(F("SI7021 found with ID: "));
    Serial.println(si7021_device_id);
    
    // Get first reading.
    si7021_read();
    Serial.print(F("SI7021 t: "));
    Serial.println(si7021_temperature / 100.0);
    Serial.print(F("SI7021 h: "));
    Serial.println(si7021_humidity / 100.0);
  } else {
    Serial.print(F("Invalid SI7021 device ID: "));
    Serial.println(si7021_device_id);
  }

  delay(2000);

  #if (RF69_COMPAT)
    Serial.println(F("RFM69CW enabled: "));
  #else
    Serial.println(F("RFM12B enabled: "));
  #endif

  Serial.print(F("  Node: "));
  Serial.println(node_id);
  
  Serial.println(F("  Frequency: 433 MHz"));
  
  Serial.print(F("  Network: "));
  Serial.println(network_group);
  
  delay(20);
}

void rf_setup(unsigned int node_id, unsigned int network_group) {
  delay(10);
  rf12_initialize(node_id, RF12_433MHZ, network_group);
}

bool rf_rx_handle() {
  if (rf12_recvDone()) {		//if RF Packet is received
    if (rf12_crc == 0) {		//Check packet is good
      Serial.print(F("OK"));		//Print "good packet" line prefix
      print_frame(rf12_len);		//Print recieved data
      if (RF12_WANTS_ACK==1) {
        // Serial.print(F(" -> ack"));
        rf12_sendStart(RF12_ACK_REPLY, 0, 0);
      }
      return true;
    } else {
      #ifdef DEBUG
      Serial.print(F(" ?"));    	//Print the "bad packet" line prefix
      print_frame(20);          	//Print only the first 20 bytes of a bad packet
      #endif
    }
  }
  return false;
}

void rf_send() {
  if (cmd && rf12_canSend() ) {                                                //if command 'cmd' is waiting to be sent then let's send it
    //led_flash(1, 200);
    byte header = cmd == 'a' ? RF12_HDR_ACK : 0;

    if (dest) {
      header |= RF12_HDR_DST | dest;
    }
    
    rf12_sendStart(header, stack, sizeof stack);
    cmd = 0;
  }
}

void print_frame(int len) {
  Serial.print(F(" "));
  Serial.print(rf12_hdr & 0x1F);        // Extract and print node ID
  Serial.print(F(" "));
  for (byte i = 0; i < len; ++i) {
    Serial.print((word) rf12_data[i]);
    Serial.print(F(" "));
  }
  #if RF69_COMPAT
  // display RSSI value after packet data e.g (-xx)
  Serial.print(F("("));
  Serial.print(-(RF69::rssi>>1));
  Serial.print(F(")"));
  #endif
  Serial.println();
}

void dodelay(unsigned int period) {
  // Back up ADC state.
  byte old_ADCSRA = ADCSRA;
  byte old_ADCSRB = ADCSRB;
  byte old_ADMUX = ADMUX;

  // Enter low power mode for specified time (ms), valid range 16-65000 ms.
  Sleepy::loseSomeTime(period);

  // Restore ADC state.
  ADCSRA = old_ADCSRA;
  ADCSRB = old_ADCSRB;
  ADMUX = old_ADMUX;
}
