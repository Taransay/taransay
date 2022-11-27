PROJECT = taransay_base
SOURCE = $(PROJECT).ino
HEX = $(SOURCE).hex
FQBN = arduino:avr:nano
PROGRAMMER = atmel_ice

.PHONY: compile upload clean

compile: $(HEX)

upload: compile
	arduino-cli upload -P $(PROGRAMMER) --fqbn $(FQBN) --input-dir $(CURDIR) -v

clean:
	rm $(SOURCE).*

$(HEX): $(SOURCE)
	arduino-cli compile --fqbn $(FQBN) --output-dir $(CURDIR) $(PROJECT)
