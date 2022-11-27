Taransay firmware
=================

Programming ATmega328P
----------------------

Using `avr-gcc` and `avrdude`. Alternative is to install Arduino IDE.

Requirements for Ubuntu:

```bash
sudo apt install gcc-avr binutils-avr gdb-avr avr-libc avrdude
```

Programmer might require special `udev` rules on Ubuntu. For instance, here is a `udev` entry for
the Atmel ICE, which should go in `/etc/udev/rules.d/99-atmelice.rules`:

```
SUBSYSTEM!="usb", ACTION!="add", GOTO="atmelice_end"

# Atmel Corp. Atmel ICE
ATTR{idVendor}=="03eb", ATTR{idProduct}=="2141", MODE="660", GROUP="dialout"

LABEL="atmelice_end"
```

After creating, restart `udev` with `sudo service udev restart`. Also ensure your user is part of
the `dialout` group.

Set fuses
---------

```
avrdude -p atmega328p -P usb -c atmelice_isp -U lfuse:w:0xff:m -U hfuse:w:0xd9:m -U efuse:w:0xff:m
```

Need to set those fuses otherwise weird serial outputs occur with characters etc.

Programming with ISP
--------------------

6-pin ISP header should be oriented with notch facing towards edge of board.

UART header mapping (starting from edge of board): GND, RX on board / TX on converter, TX on board /
RX on converter, DTR, 3V3

```
avrdude -p atmega328p -P usb -c atmelice_isp -U flash:w:taransay_X.ino.eightanaloginputs.hex
```

View device serial
------------------

```
minicom -b 115200 -D /dev/ttyUSB0
```

Writing messages to serial device
---------------------------------

```
echo -en 'hello\n' > /dev/ttyUSB0
```
