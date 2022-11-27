EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:Screw_Terminal_01x08 J1
U 1 1 6183EEC8
P 1150 2000
F 0 "J1" H 1100 2500 50  0000 C CNN
F 1 "Power" H 1100 2400 50  0000 C CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_MKDS-3-8-5.08_1x08_P5.08mm_Horizontal" H 1150 2000 50  0001 C CNN
F 3 "~" H 1150 2000 50  0001 C CNN
	1    1150 2000
	-1   0    0    -1  
$EndComp
$Comp
L Device:Varistor RV1
U 1 1 61848198
P 3050 1900
F 0 "RV1" H 3153 1946 50  0000 L CNN
F 1 "Varistor" H 3153 1855 50  0000 L CNN
F 2 "Varistor:RV_Disc_D7mm_W5.7mm_P5mm" V 2980 1900 50  0001 C CNN
F 3 "~" H 3050 1900 50  0001 C CNN
F 4 "Mouser" H 3050 1900 50  0001 C CNN "Vendor1"
F 5 "652-CV300K5BL1" H 3050 1900 50  0001 C CNN "SKU1"
	1    3050 1900
	1    0    0    -1  
$EndComp
$Comp
L Device:Fuse F1
U 1 1 6185E982
P 2750 1700
F 0 "F1" V 2553 1700 50  0000 C CNN
F 1 "50 mA, T" V 2644 1700 50  0000 C CNN
F 2 "Fuse:Fuseholder_Cylinder-5x20mm_Schurter_0031_8201_Horizontal_Open" V 2680 1700 50  0001 C CNN
F 3 "~" H 2750 1700 50  0001 C CNN
	1    2750 1700
	0    1    1    0   
$EndComp
$Comp
L Relay:FINDER-32.21-x000 K1
U 1 1 61864495
P 2850 3050
F 0 "K1" H 3200 2800 50  0000 C CNN
F 1 "FINDER-32.21-x000" H 3100 2600 50  0000 C CNN
F 2 "Relay_THT:Relay_SPDT_Finder_32.21-x000" H 4120 3020 50  0001 C CNN
F 3 "https://gfinder.findernet.com/assets/Series/355/S32EN.pdf" H 2850 3050 50  0001 C CNN
	1    2850 3050
	-1   0    0    -1  
$EndComp
$Comp
L Converter_ACDC:RAC01-05SGB PS1
U 1 1 6186AC4E
P 3850 1900
F 0 "PS1" H 3850 2267 50  0000 C CNN
F 1 "RAC01-05SGB" H 3850 2176 50  0000 C CNN
F 2 "Converter_ACDC:Converter_ACDC_RECOM_RAC01-xxSGB_THT" H 3850 1550 50  0001 C CNN
F 3 "https://www.recom-power.com/pdf/Powerline-AC-DC/RAC01-GB.pdf" H 3700 1900 50  0001 C CNN
F 4 "Mouser" H 3850 1900 50  0001 C CNN "Vendor1"
F 5 " 919-RAC01-05SGB" H 3850 1900 50  0001 C CNN "SKU1"
	1    3850 1900
	1    0    0    -1  
$EndComp
Text Notes 3550 2250 0    50   ~ 0
pin compatible with 3V3 etc.
$Comp
L Device:D_Small D1
U 1 1 618AA11F
P 4450 1900
F 0 "D1" V 4404 1980 50  0000 L CNN
F 1 "SMBJ7.0A" V 4495 1980 50  0000 L CNN
F 2 "Diode_SMD:D_SMB" H 4450 1900 50  0001 C CNN
F 3 "https://www.littelfuse.com/~/media/electronics/datasheets/tvs_diodes/littelfuse_tvs_diode_smbj_datasheet.pdf.pdf" H 4450 1900 50  0001 C CNN
	1    4450 1900
	0    1    1    0   
$EndComp
Text Label 8300 3450 2    50   ~ 0
A0
Text Label 8300 3350 2    50   ~ 0
A1
Text Label 8300 3250 2    50   ~ 0
A2
Text Label 8300 3150 2    50   ~ 0
A3
Text Label 8300 3050 2    50   ~ 0
A4
Text Label 8300 2950 2    50   ~ 0
A5
Text Notes 8150 3050 2    50   ~ 0
SDA
Text Notes 8150 2950 2    50   ~ 0
SCL
Text Label 8300 3550 2    50   ~ 0
AREF
Text Label 8300 2850 2    50   ~ 0
A6
Text Label 8300 2750 2    50   ~ 0
A7
Text Notes 8150 2750 2    50   ~ 0
BATT
Wire Wire Line
	8400 3800 8300 3800
Wire Wire Line
	8400 3900 8300 3900
Wire Wire Line
	8400 4000 8300 4000
Wire Wire Line
	8400 4100 8300 4100
Wire Wire Line
	8400 4200 8300 4200
Wire Wire Line
	8400 4300 8300 4300
Wire Wire Line
	8400 4400 8300 4400
Wire Wire Line
	8400 4500 8300 4500
Wire Wire Line
	8400 4600 8300 4600
Wire Wire Line
	8400 4700 8300 4700
Wire Wire Line
	8400 4800 8300 4800
Wire Wire Line
	8400 4900 8300 4900
Wire Wire Line
	8400 5000 8300 5000
Wire Wire Line
	8400 5100 8300 5100
Text Label 8300 3800 2    50   ~ 0
D0
Text Notes 8100 3800 2    50   ~ 0
RX
Text Label 8300 3900 2    50   ~ 0
D1
Text Notes 8100 3900 2    50   ~ 0
TX
Text Label 8300 4000 2    50   ~ 0
D2
Text Label 8300 4100 2    50   ~ 0
D3
Text Label 8300 4200 2    50   ~ 0
D4
Text Label 8300 4300 2    50   ~ 0
D5
Text Label 8300 4400 2    50   ~ 0
D6
Text Label 8300 4500 2    50   ~ 0
D7
Text Label 8300 4600 2    50   ~ 0
D8
Text Label 8300 4700 2    50   ~ 0
D9
Text Label 8300 4800 2    50   ~ 0
D10
Text Label 8300 4900 2    50   ~ 0
D11
Text Notes 8100 4900 2    50   ~ 0
MOSI
Text Label 8300 5000 2    50   ~ 0
D12
Text Label 8300 5100 2    50   ~ 0
D13
Text Notes 8100 5100 2    50   ~ 0
SCK
Text Notes 8100 5000 2    50   ~ 0
MISO
Text Notes 8100 4800 2    50   ~ 0
SS RF
Text Notes 8100 4000 2    50   ~ 0
IRQ
Text Notes 8100 4400 2    50   ~ 0
LED
Text Label 8300 5200 2    50   ~ 0
~RST
$Comp
L Connector_Generic:Conn_01x15 J6
U 1 1 618A297D
P 8600 4500
F 0 "J6" H 8680 4492 50  0000 L CNN
F 1 "Digital" H 8680 4401 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x15_P2.54mm_Vertical" H 8600 4500 50  0001 C CNN
F 3 "~" H 8600 4500 50  0001 C CNN
	1    8600 4500
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x15 J5
U 1 1 618A2987
P 8600 2850
F 0 "J5" H 8680 2842 50  0000 L CNN
F 1 "Analog" H 8680 2751 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x15_P2.54mm_Vertical" H 8600 2850 50  0001 C CNN
F 3 "~" H 8600 2850 50  0001 C CNN
	1    8600 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	8400 2150 8350 2150
Wire Wire Line
	8400 2350 8050 2350
Wire Wire Line
	8400 2450 8300 2450
Wire Wire Line
	8400 2550 8300 2550
Wire Wire Line
	8400 2650 8050 2650
Wire Wire Line
	8400 2750 8300 2750
Wire Wire Line
	8400 2850 8300 2850
Wire Wire Line
	8400 2950 8300 2950
Wire Wire Line
	8400 3050 8300 3050
Wire Wire Line
	8400 3150 8300 3150
Wire Wire Line
	8400 3250 8300 3250
Wire Wire Line
	8400 3350 8300 3350
Wire Wire Line
	8400 3450 8300 3450
$Comp
L power:VDC #PWR0101
U 1 1 618A299E
P 8050 2150
F 0 "#PWR0101" H 8050 2050 50  0001 C CNN
F 1 "VDC" V 8050 2300 50  0000 L CNN
F 2 "" H 8050 2150 50  0001 C CNN
F 3 "" H 8050 2150 50  0001 C CNN
	1    8050 2150
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 618A29A8
P 8050 2350
F 0 "#PWR0102" H 8050 2100 50  0001 C CNN
F 1 "GND" V 8055 2222 50  0000 R CNN
F 2 "" H 8050 2350 50  0001 C CNN
F 3 "" H 8050 2350 50  0001 C CNN
	1    8050 2350
	0    1    1    0   
$EndComp
Text Label 8300 2450 2    50   ~ 0
D0
Text Notes 8150 2450 2    50   ~ 0
RX
Text Label 8300 2550 2    50   ~ 0
D1
Text Notes 8150 2550 2    50   ~ 0
TX
$Comp
L power:+3V3 #PWR0103
U 1 1 618A29BA
P 8050 2650
F 0 "#PWR0103" H 8050 2500 50  0001 C CNN
F 1 "+3V3" V 8065 2778 50  0000 L CNN
F 2 "" H 8050 2650 50  0001 C CNN
F 3 "" H 8050 2650 50  0001 C CNN
	1    8050 2650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8400 2250 8350 2250
Wire Wire Line
	8350 2250 8350 2150
Connection ~ 8350 2150
Wire Wire Line
	8350 2150 8050 2150
Wire Wire Line
	8400 5200 8300 5200
Wire Wire Line
	8400 3550 8300 3550
Wire Wire Line
	3450 1800 3400 1800
Wire Wire Line
	3400 1800 3400 1700
Wire Wire Line
	3400 1700 3050 1700
Wire Wire Line
	3050 1700 3050 1750
Wire Wire Line
	3450 2000 3400 2000
Wire Wire Line
	3400 2000 3400 2100
Wire Wire Line
	3400 2100 3050 2100
Wire Wire Line
	3050 2100 3050 2050
Wire Wire Line
	2900 1700 3050 1700
Connection ~ 3050 1700
Connection ~ 3050 2100
Wire Wire Line
	4250 1800 4250 1700
Wire Wire Line
	4250 1700 4450 1700
Wire Wire Line
	4450 1700 4450 1800
Wire Wire Line
	4250 2000 4250 2100
Wire Wire Line
	4250 2100 4450 2100
Wire Wire Line
	4450 2100 4450 2000
Connection ~ 4450 1700
Connection ~ 4450 2100
$Comp
L Device:CP_Small C1
U 1 1 6190C4F4
P 5000 1900
F 0 "C1" H 5088 1946 50  0000 L CNN
F 1 "68u" H 5088 1855 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 5000 1900 50  0001 C CNN
F 3 "~" H 5000 1900 50  0001 C CNN
	1    5000 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 1800 5000 1700
Wire Wire Line
	4450 1700 5000 1700
Wire Wire Line
	5000 2100 5000 2000
Wire Wire Line
	4450 2100 5000 2100
Wire Wire Line
	5000 1700 5400 1700
Connection ~ 5000 1700
$Comp
L power:GND #PWR0104
U 1 1 6191ABA5
P 5800 2150
F 0 "#PWR0104" H 5800 1900 50  0001 C CNN
F 1 "GND" V 5805 2022 50  0000 R CNN
F 2 "" H 5800 2150 50  0001 C CNN
F 3 "" H 5800 2150 50  0001 C CNN
	1    5800 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 2100 5000 2100
Connection ~ 5000 2100
$Comp
L power:VDC #PWR0105
U 1 1 6191CA3F
P 5800 1650
F 0 "#PWR0105" H 5800 1550 50  0001 C CNN
F 1 "VDC" V 5800 1800 50  0000 L CNN
F 2 "" H 5800 1650 50  0001 C CNN
F 3 "" H 5800 1650 50  0001 C CNN
	1    5800 1650
	1    0    0    -1  
$EndComp
Text Notes 4300 1650 0    50   ~ 0
5 VDC
Wire Wire Line
	2750 2100 3050 2100
Text Notes 1500 1700 0    50   ~ 0
Live
$Comp
L power:Earth_Protective #PWR0106
U 1 1 619413AD
P 1400 2550
F 0 "#PWR0106" H 1650 2300 50  0001 C CNN
F 1 "Earth_Protective" H 1850 2400 50  0001 C CNN
F 2 "" H 1400 2450 50  0001 C CNN
F 3 "~" H 1400 2450 50  0001 C CNN
	1    1400 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R1
U 1 1 61957B22
P 5400 1900
F 0 "R1" H 5459 1946 50  0000 L CNN
F 1 "NP" H 5459 1855 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" H 5400 1900 50  0001 C CNN
F 3 "~" H 5400 1900 50  0001 C CNN
	1    5400 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 1800 5400 1700
Connection ~ 5400 1700
Wire Wire Line
	5400 2000 5400 2100
Connection ~ 5400 2100
Wire Wire Line
	2650 3350 2650 3400
Wire Wire Line
	2650 3400 2350 3400
$Comp
L power:VDC #PWR0107
U 1 1 6198BF72
P 3050 2600
F 0 "#PWR0107" H 3050 2500 50  0001 C CNN
F 1 "VDC" V 3050 2750 50  0000 L CNN
F 2 "" H 3050 2600 50  0001 C CNN
F 3 "" H 3050 2600 50  0001 C CNN
	1    3050 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 2600 3050 2650
Connection ~ 3050 2650
Wire Wire Line
	3050 2650 3050 2750
Wire Wire Line
	3050 2650 3400 2650
$Comp
L Device:D_Small D4
U 1 1 619AD818
P 3400 3300
F 0 "D4" V 3350 3150 50  0000 L CNN
F 1 "SMBJ7.0A" V 3450 2900 50  0000 L CNN
F 2 "Diode_SMD:D_SMB" H 3400 3300 50  0001 C CNN
F 3 "https://www.littelfuse.com/~/media/electronics/datasheets/tvs_diodes/littelfuse_tvs_diode_smbj_datasheet.pdf.pdf" H 3400 3300 50  0001 C CNN
	1    3400 3300
	0    -1   -1   0   
$EndComp
$Comp
L Device:D_Small D3
U 1 1 619AE478
P 3400 3050
F 0 "D3" V 3354 3130 50  0000 L CNN
F 1 "SM4007" V 3445 3130 50  0000 L CNN
F 2 "Diode_SMD:D_MELF" H 3400 3050 50  0001 C CNN
F 3 "https://www.littelfuse.com/~/media/electronics/datasheets/tvs_diodes/littelfuse_tvs_diode_smbj_datasheet.pdf.pdf" H 3400 3050 50  0001 C CNN
	1    3400 3050
	0    1    1    0   
$EndComp
$Comp
L Device:D_Small D2
U 1 1 619AEF73
P 3400 2800
F 0 "D2" V 3354 2880 50  0000 L CNN
F 1 "SM4007" V 3445 2880 50  0000 L CNN
F 2 "Diode_SMD:D_MELF" H 3400 2800 50  0001 C CNN
F 3 "https://www.littelfuse.com/~/media/electronics/datasheets/tvs_diodes/littelfuse_tvs_diode_smbj_datasheet.pdf.pdf" H 3400 2800 50  0001 C CNN
	1    3400 2800
	0    1    1    0   
$EndComp
Wire Wire Line
	3400 3150 3400 3200
Wire Wire Line
	3400 2950 3400 2900
Wire Wire Line
	3400 2700 3400 2650
Wire Wire Line
	3400 3400 3400 3450
Wire Wire Line
	3400 3450 3050 3450
Wire Wire Line
	3050 3450 3050 3350
Wire Wire Line
	3050 3650 3050 3450
Connection ~ 3050 3450
Wire Wire Line
	3050 4050 3050 4100
$Comp
L power:GND #PWR0108
U 1 1 619DCC41
P 3050 4100
F 0 "#PWR0108" H 3050 3850 50  0001 C CNN
F 1 "GND" V 3055 3972 50  0000 R CNN
F 2 "" H 3050 4100 50  0001 C CNN
F 3 "" H 3050 4100 50  0001 C CNN
	1    3050 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 3850 3400 3850
$Comp
L Device:R_Small R2
U 1 1 619E200F
P 3500 3850
F 0 "R2" V 3700 3800 50  0000 L CNN
F 1 "3k01" V 3600 3750 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" H 3500 3850 50  0001 C CNN
F 3 "~" H 3500 3850 50  0001 C CNN
	1    3500 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3600 3850 3700 3850
$Comp
L Device:Q_NPN_BEC Q1
U 1 1 619EC41C
P 3150 3850
F 0 "Q1" H 3341 3896 50  0000 L CNN
F 1 "BC847" H 3341 3805 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3350 3950 50  0001 C CNN
F 3 "http://www.infineon.com/dgdl/Infineon-BC847SERIES_BC848SERIES_BC849SERIES_BC850SERIES-DS-v01_01-en.pdf?fileId=db3a304314dca389011541d4630a1657" H 3150 3850 50  0001 C CNN
	1    3150 3850
	-1   0    0    -1  
$EndComp
Text Label 3700 3850 0    50   ~ 0
D3
Text Notes 8100 4100 2    50   ~ 0
Switch 1
Text Notes 1500 1900 0    50   ~ 0
Switch 1
Text Notes 1500 2100 0    50   ~ 0
Switch 2
Wire Wire Line
	1350 1700 1950 1700
Wire Wire Line
	2350 3400 2350 1700
Connection ~ 2350 1700
Wire Wire Line
	2350 1700 2600 1700
$Comp
L Relay:FINDER-32.21-x000 K2
U 1 1 61A61C61
P 2450 4850
F 0 "K2" H 2800 4600 50  0000 C CNN
F 1 "FINDER-32.21-x000" H 2700 4400 50  0000 C CNN
F 2 "Relay_THT:Relay_SPDT_Finder_32.21-x000" H 3720 4820 50  0001 C CNN
F 3 "https://gfinder.findernet.com/assets/Series/355/S32EN.pdf" H 2450 4850 50  0001 C CNN
	1    2450 4850
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2250 5150 2250 5200
Wire Wire Line
	2250 5200 1950 5200
$Comp
L power:VDC #PWR0109
U 1 1 61A61EE3
P 2650 4400
F 0 "#PWR0109" H 2650 4300 50  0001 C CNN
F 1 "VDC" V 2650 4550 50  0000 L CNN
F 2 "" H 2650 4400 50  0001 C CNN
F 3 "" H 2650 4400 50  0001 C CNN
	1    2650 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 4400 2650 4450
Connection ~ 2650 4450
Wire Wire Line
	2650 4450 2650 4550
Wire Wire Line
	2650 4450 2950 4450
$Comp
L Device:D_Small D7
U 1 1 61A61EF1
P 2950 5100
F 0 "D7" V 2900 4950 50  0000 L CNN
F 1 "SMBJ7.0A" V 3000 4700 50  0000 L CNN
F 2 "Diode_SMD:D_SMB" H 2950 5100 50  0001 C CNN
F 3 "https://www.littelfuse.com/~/media/electronics/datasheets/tvs_diodes/littelfuse_tvs_diode_smbj_datasheet.pdf.pdf" H 2950 5100 50  0001 C CNN
	1    2950 5100
	0    -1   -1   0   
$EndComp
$Comp
L Device:D_Small D6
U 1 1 61A61EFB
P 2950 4850
F 0 "D6" V 2904 4930 50  0000 L CNN
F 1 "SM4007" V 2995 4930 50  0000 L CNN
F 2 "Diode_SMD:D_MELF" H 2950 4850 50  0001 C CNN
F 3 "https://www.littelfuse.com/~/media/electronics/datasheets/tvs_diodes/littelfuse_tvs_diode_smbj_datasheet.pdf.pdf" H 2950 4850 50  0001 C CNN
	1    2950 4850
	0    1    1    0   
$EndComp
$Comp
L Device:D_Small D5
U 1 1 61A61F05
P 2950 4600
F 0 "D5" V 2904 4680 50  0000 L CNN
F 1 "SM4007" V 2995 4680 50  0000 L CNN
F 2 "Diode_SMD:D_MELF" H 2950 4600 50  0001 C CNN
F 3 "https://www.littelfuse.com/~/media/electronics/datasheets/tvs_diodes/littelfuse_tvs_diode_smbj_datasheet.pdf.pdf" H 2950 4600 50  0001 C CNN
	1    2950 4600
	0    1    1    0   
$EndComp
Wire Wire Line
	2950 4950 2950 5000
Wire Wire Line
	2950 4750 2950 4700
Wire Wire Line
	2950 4500 2950 4450
Wire Wire Line
	2950 5200 2950 5250
Wire Wire Line
	2950 5250 2650 5250
Wire Wire Line
	2650 5250 2650 5150
Wire Wire Line
	2650 5450 2650 5250
Connection ~ 2650 5250
Wire Wire Line
	2650 5850 2650 5900
$Comp
L power:GND #PWR0110
U 1 1 61A61F18
P 2650 5900
F 0 "#PWR0110" H 2650 5650 50  0001 C CNN
F 1 "GND" V 2655 5772 50  0000 R CNN
F 2 "" H 2650 5900 50  0001 C CNN
F 3 "" H 2650 5900 50  0001 C CNN
	1    2650 5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 5650 3000 5650
$Comp
L Device:R_Small R3
U 1 1 61A61F23
P 3100 5650
F 0 "R3" V 3300 5600 50  0000 L CNN
F 1 "3k01" V 3200 5550 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" H 3100 5650 50  0001 C CNN
F 3 "~" H 3100 5650 50  0001 C CNN
	1    3100 5650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3200 5650 3300 5650
$Comp
L Device:Q_NPN_BEC Q2
U 1 1 61A61F2E
P 2750 5650
F 0 "Q2" H 2941 5696 50  0000 L CNN
F 1 "BC847" H 2941 5605 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 2950 5750 50  0001 C CNN
F 3 "http://www.infineon.com/dgdl/Infineon-BC847SERIES_BC848SERIES_BC849SERIES_BC850SERIES-DS-v01_01-en.pdf?fileId=db3a304314dca389011541d4630a1657" H 2750 5650 50  0001 C CNN
	1    2750 5650
	-1   0    0    -1  
$EndComp
Text Label 3300 5650 0    50   ~ 0
D4
Wire Wire Line
	1950 1700 1950 5200
Connection ~ 1950 1700
Wire Wire Line
	1950 1700 2350 1700
Text Notes 8100 4200 2    50   ~ 0
Switch 2
Wire Wire Line
	1350 2300 1400 2300
Wire Wire Line
	1400 2300 1400 2400
Wire Wire Line
	1350 2400 1400 2400
Connection ~ 1400 2400
Wire Wire Line
	1400 2400 1400 2550
Wire Wire Line
	2750 2100 2750 2000
Wire Wire Line
	2750 1800 1350 1800
Wire Wire Line
	1350 1900 2550 1900
Connection ~ 2750 2000
Wire Wire Line
	2750 2000 2750 1800
Text Notes 1500 1800 0    50   ~ 0
Neutral
Text Notes 1500 2000 0    50   ~ 0
Neutral
Wire Wire Line
	1350 2000 2750 2000
Wire Wire Line
	2550 2750 2550 1900
Wire Wire Line
	2150 4550 2150 2100
Wire Wire Line
	2150 2100 1350 2100
Text Notes 1500 2200 0    50   ~ 0
Neutral
Wire Wire Line
	1350 2200 2750 2200
Wire Wire Line
	2750 2200 2750 2100
Connection ~ 2750 2100
$Comp
L Connector_Generic:Conn_01x03 J2
U 1 1 61B5F50A
P 6350 1900
F 0 "J2" H 6430 1942 50  0000 L CNN
F 1 "DC" H 6430 1851 50  0000 L CNN
F 2 "Connector_Wire:SolderWire-0.75sqmm_1x03_P4.8mm_D1.25mm_OD2.3mm" H 6350 1900 50  0001 C CNN
F 3 "~" H 6350 1900 50  0001 C CNN
	1    6350 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 1800 5800 1800
Wire Wire Line
	5800 1800 5800 1700
Wire Wire Line
	5800 1700 5400 1700
Wire Wire Line
	6150 2000 5800 2000
Wire Wire Line
	5800 2000 5800 2100
Wire Wire Line
	5800 2100 5400 2100
Wire Wire Line
	5800 1700 5800 1650
Connection ~ 5800 1700
Wire Wire Line
	5800 2100 5800 2150
Connection ~ 5800 2100
$Comp
L Connector_Generic:Conn_01x02 J3
U 1 1 61B80611
P 6350 2800
F 0 "J3" H 6430 2792 50  0000 L CNN
F 1 "External button 1" H 6430 2701 50  0000 L CNN
F 2 "Connector_Wire:SolderWire-0.75sqmm_1x02_P4.8mm_D1.25mm_OD2.3mm" H 6350 2800 50  0001 C CNN
F 3 "~" H 6350 2800 50  0001 C CNN
	1    6350 2800
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J4
U 1 1 61B8195A
P 6350 3500
F 0 "J4" H 6430 3492 50  0000 L CNN
F 1 "External button 2" H 6430 3401 50  0000 L CNN
F 2 "Connector_Wire:SolderWire-0.75sqmm_1x02_P4.8mm_D1.25mm_OD2.3mm" H 6350 3500 50  0001 C CNN
F 3 "~" H 6350 3500 50  0001 C CNN
	1    6350 3500
	1    0    0    -1  
$EndComp
Text Notes 8100 4500 2    50   ~ 0
~External button 1
Text Notes 8100 4600 2    50   ~ 0
~External button 2
Text Notes 8100 4700 2    50   ~ 0
SS external
Wire Wire Line
	5600 3500 6150 3500
Wire Wire Line
	5600 2800 6150 2800
$Comp
L Device:CP_Small C3
U 1 1 61DC5A6F
P 5250 3650
F 0 "C3" H 5338 3696 50  0000 L CNN
F 1 "1u" H 5338 3605 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 5250 3650 50  0001 C CNN
F 3 "~" H 5250 3650 50  0001 C CNN
	1    5250 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:CP_Small C2
U 1 1 61DC4966
P 5250 2950
F 0 "C2" H 5338 2996 50  0000 L CNN
F 1 "1u" H 5338 2905 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 5250 2950 50  0001 C CNN
F 3 "~" H 5250 2950 50  0001 C CNN
	1    5250 2950
	1    0    0    -1  
$EndComp
Connection ~ 5250 3500
Wire Wire Line
	5400 3500 5250 3500
Connection ~ 5250 2800
Wire Wire Line
	5400 2800 5250 2800
$Comp
L Device:R_Small R5
U 1 1 61D81978
P 5500 3500
F 0 "R5" V 5304 3500 50  0000 C CNN
F 1 "1k" V 5395 3500 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" H 5500 3500 50  0001 C CNN
F 3 "~" H 5500 3500 50  0001 C CNN
	1    5500 3500
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R4
U 1 1 61D7FCE1
P 5500 2800
F 0 "R4" V 5304 2800 50  0000 C CNN
F 1 "1k" V 5395 2800 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" H 5500 2800 50  0001 C CNN
F 3 "~" H 5500 2800 50  0001 C CNN
	1    5500 2800
	0    1    1    0   
$EndComp
Wire Wire Line
	5950 4000 5950 3950
Connection ~ 5950 3950
Connection ~ 5900 3800
Wire Wire Line
	5900 3950 5950 3950
Wire Wire Line
	5900 3800 5900 3950
Connection ~ 6000 3100
Wire Wire Line
	6000 3950 5950 3950
Wire Wire Line
	6000 3100 6000 3950
Wire Wire Line
	5150 3500 5250 3500
Wire Wire Line
	5250 3800 5250 3750
Wire Wire Line
	5900 3800 5250 3800
Wire Wire Line
	5900 3600 5900 3800
Wire Wire Line
	6150 3600 5900 3600
Wire Wire Line
	5250 3550 5250 3500
Wire Wire Line
	5250 3100 5250 3050
Wire Wire Line
	6000 3100 5250 3100
Wire Wire Line
	6000 2900 6000 3100
Wire Wire Line
	6150 2900 6000 2900
Wire Wire Line
	5250 2800 5150 2800
Wire Wire Line
	5250 2850 5250 2800
Text Label 5150 3500 2    50   ~ 0
D8
Text Label 5150 2800 2    50   ~ 0
D7
$Comp
L power:GND #PWR0111
U 1 1 61B8449E
P 5950 4000
F 0 "#PWR0111" H 5950 3750 50  0001 C CNN
F 1 "GND" V 5955 3872 50  0000 R CNN
F 2 "" H 5950 4000 50  0001 C CNN
F 3 "" H 5950 4000 50  0001 C CNN
	1    5950 4000
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0112
U 1 1 61E72BC7
P 6100 1900
F 0 "#PWR0112" H 6100 1750 50  0001 C CNN
F 1 "+3V3" V 6115 2028 50  0000 L CNN
F 2 "" H 6100 1900 50  0001 C CNN
F 3 "" H 6100 1900 50  0001 C CNN
	1    6100 1900
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6100 1900 6150 1900
Text Label 9900 3450 2    50   ~ 0
A0
Text Label 9900 3350 2    50   ~ 0
A1
Text Label 9900 3250 2    50   ~ 0
A2
Text Label 9900 3150 2    50   ~ 0
A3
Text Label 9900 3050 2    50   ~ 0
A4
Text Label 9900 2950 2    50   ~ 0
A5
Text Notes 9750 3050 2    50   ~ 0
SDA
Text Notes 9750 2950 2    50   ~ 0
SCL
Text Label 9900 3550 2    50   ~ 0
AREF
Text Label 9900 2850 2    50   ~ 0
A6
Text Label 9900 2750 2    50   ~ 0
A7
Text Notes 9750 2750 2    50   ~ 0
BATT
$Comp
L Connector_Generic:Conn_01x15 J7
U 1 1 61EE0789
P 10200 2850
F 0 "J7" H 10280 2842 50  0000 L CNN
F 1 "Analog breakout" H 10280 2751 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x15_P2.54mm_Vertical" H 10200 2850 50  0001 C CNN
F 3 "~" H 10200 2850 50  0001 C CNN
	1    10200 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	10000 2150 9950 2150
Wire Wire Line
	10000 2350 9650 2350
Wire Wire Line
	10000 2450 9900 2450
Wire Wire Line
	10000 2550 9900 2550
Wire Wire Line
	10000 2650 9650 2650
Wire Wire Line
	10000 2750 9900 2750
Wire Wire Line
	10000 2850 9900 2850
Wire Wire Line
	10000 2950 9900 2950
Wire Wire Line
	10000 3050 9900 3050
Wire Wire Line
	10000 3150 9900 3150
Wire Wire Line
	10000 3250 9900 3250
Wire Wire Line
	10000 3350 9900 3350
Wire Wire Line
	10000 3450 9900 3450
$Comp
L power:VDC #PWR0113
U 1 1 61EE07A0
P 9650 2150
F 0 "#PWR0113" H 9650 2050 50  0001 C CNN
F 1 "VDC" V 9650 2300 50  0000 L CNN
F 2 "" H 9650 2150 50  0001 C CNN
F 3 "" H 9650 2150 50  0001 C CNN
	1    9650 2150
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0114
U 1 1 61EE07AA
P 9650 2350
F 0 "#PWR0114" H 9650 2100 50  0001 C CNN
F 1 "GND" V 9655 2222 50  0000 R CNN
F 2 "" H 9650 2350 50  0001 C CNN
F 3 "" H 9650 2350 50  0001 C CNN
	1    9650 2350
	0    1    1    0   
$EndComp
Text Label 9900 2450 2    50   ~ 0
D0
Text Notes 9750 2450 2    50   ~ 0
RX
Text Label 9900 2550 2    50   ~ 0
D1
Text Notes 9750 2550 2    50   ~ 0
TX
$Comp
L power:+3V3 #PWR0115
U 1 1 61EE07B8
P 9650 2650
F 0 "#PWR0115" H 9650 2500 50  0001 C CNN
F 1 "+3V3" V 9665 2778 50  0000 L CNN
F 2 "" H 9650 2650 50  0001 C CNN
F 3 "" H 9650 2650 50  0001 C CNN
	1    9650 2650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10000 2250 9950 2250
Wire Wire Line
	9950 2250 9950 2150
Connection ~ 9950 2150
Wire Wire Line
	9950 2150 9650 2150
Wire Wire Line
	10000 3550 9900 3550
Wire Wire Line
	10000 3800 9900 3800
Wire Wire Line
	10000 3900 9900 3900
Wire Wire Line
	10000 4000 9900 4000
Wire Wire Line
	10000 4100 9900 4100
Wire Wire Line
	10000 4200 9900 4200
Wire Wire Line
	10000 4300 9900 4300
Wire Wire Line
	10000 4400 9900 4400
Wire Wire Line
	10000 4500 9900 4500
Wire Wire Line
	10000 4600 9900 4600
Wire Wire Line
	10000 4700 9900 4700
Wire Wire Line
	10000 4800 9900 4800
Wire Wire Line
	10000 4900 9900 4900
Wire Wire Line
	10000 5000 9900 5000
Wire Wire Line
	10000 5100 9900 5100
Text Label 9900 3800 2    50   ~ 0
D0
Text Notes 9700 3800 2    50   ~ 0
RX
Text Label 9900 3900 2    50   ~ 0
D1
Text Notes 9700 3900 2    50   ~ 0
TX
Text Label 9900 4000 2    50   ~ 0
D2
Text Label 9900 4100 2    50   ~ 0
D3
Text Label 9900 4200 2    50   ~ 0
D4
Text Label 9900 4300 2    50   ~ 0
D5
Text Label 9900 4400 2    50   ~ 0
D6
Text Label 9900 4500 2    50   ~ 0
D7
Text Label 9900 4600 2    50   ~ 0
D8
Text Label 9900 4700 2    50   ~ 0
D9
Text Label 9900 4800 2    50   ~ 0
D10
Text Label 9900 4900 2    50   ~ 0
D11
Text Notes 9700 4900 2    50   ~ 0
MOSI
Text Label 9900 5000 2    50   ~ 0
D12
Text Label 9900 5100 2    50   ~ 0
D13
Text Notes 9700 5100 2    50   ~ 0
SCK
Text Notes 9700 5000 2    50   ~ 0
MISO
Text Notes 9700 4800 2    50   ~ 0
SS RF
Text Notes 9700 4000 2    50   ~ 0
IRQ
Text Notes 9700 4400 2    50   ~ 0
LED
Text Label 9900 5200 2    50   ~ 0
~RST
$Comp
L Connector_Generic:Conn_01x15 J8
U 1 1 61EF3292
P 10200 4500
F 0 "J8" H 10280 4492 50  0000 L CNN
F 1 "Digital breakout" H 10280 4401 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x15_P2.54mm_Vertical" H 10200 4500 50  0001 C CNN
F 3 "~" H 10200 4500 50  0001 C CNN
	1    10200 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	10000 5200 9900 5200
Text Notes 9700 4100 2    50   ~ 0
Switch 1
Text Notes 9700 4200 2    50   ~ 0
Switch 2
Text Notes 9700 4500 2    50   ~ 0
~External button 1
Text Notes 9700 4600 2    50   ~ 0
~External button 2
Text Notes 9700 4700 2    50   ~ 0
SS external
NoConn ~ 2750 2750
NoConn ~ 2350 4550
$Comp
L Mechanical:MountingHole H1
U 1 1 620A5880
P 5850 6700
F 0 "H1" H 5950 6746 50  0000 L CNN
F 1 "MountingHole" H 5950 6655 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 5850 6700 50  0001 C CNN
F 3 "~" H 5850 6700 50  0001 C CNN
	1    5850 6700
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 620A68B2
P 5850 6950
F 0 "H2" H 5950 6996 50  0000 L CNN
F 1 "MountingHole" H 5950 6905 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 5850 6950 50  0001 C CNN
F 3 "~" H 5850 6950 50  0001 C CNN
	1    5850 6950
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 620B1E95
P 5850 7200
F 0 "H3" H 5950 7246 50  0000 L CNN
F 1 "MountingHole" H 5950 7155 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 5850 7200 50  0001 C CNN
F 3 "~" H 5850 7200 50  0001 C CNN
	1    5850 7200
	1    0    0    -1  
$EndComp
Text Notes 7950 1900 0    50   ~ 0
From Taransay
$EndSCHEMATC
