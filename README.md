# Taransay home monitoring hardware and firmware
This is a series of wireless (433 MHz) electricity, gas, temperature and humidity monitors, electricity switches
and RGB(W) controllers and base station, with interoperability with [Home Assistant](https://www.home-assistant.io/). It uses low cost RF modules from HopeRF for intercommunication, avoiding the security
implications of having several seldomly-updated WiFi modules on your home network. The range is also
far greater.

The hardware and firmware designs are loosely based on those of the [emonTx](https://github.com/openenergymonitor/emontx3), [emonTH](https://github.com/openenergymonitor/emonth2) (both [OpenEnergyMonitor](http://openenergymonitor.com/)) and [Moteino](https://lowpowerlab.com/guide/moteino/) (LowPowerLab).

The firmware is designed to talk to Home Assistant via the Taransay base station, which is a small
transceiver that plugs into a Raspberry Pi or similar and talks to an instance of [Taransay
Data Forwarder](https://github.com/Taransay/taransayhub) over serial. This way, you just need to
keep your Raspberry Pi updated and not several distributed devices.

## Status
The hardware and firmware all works, though there are few instructions for getting it all to work,
so if you happen to want to use any of this it's best to get in touch.

## Credits
Sean Leavey <https://github.com/SeanDS>
