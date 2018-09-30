Changes from emonTx V3.4 / emonTH V2.0
======================================

- Various component tweaks: different models, mainly
- Removed 3/4 current sensors
- Added Si7020/Si7021 temperature/humidity probe from emonTH V2
  - Reused ADC4 and ADC5 for SDA/SCL I2C bus to communicate with Si7020
  - Changed DS18B20 data pin from D5 to PC2 (ADC2) amd power pin from ADC5 to PC3 (ADC3)
- Removed ESP UART socket
- Explicitly implemented RFM69CW instead of (pin compatible) RFM12B
- Split pulse and temperature monitor ports into separate ports
  - Made PD4 the pulse power pin
- Changed pulse and temperature sockets from RJ45 to Molex Nano-Fit
- Removed AC-AC input
- Removed USB socket
