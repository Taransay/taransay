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
P 1450 2000
F 0 "J1" H 1400 2500 50  0000 C CNN
F 1 "Power" H 1400 2400 50  0000 C CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_MKDS-3-8-5.08_1x08_P5.08mm_Horizontal" H 1450 2000 50  0001 C CNN
F 3 "~" H 1450 2000 50  0001 C CNN
	1    1450 2000
	-1   0    0    -1  
$EndComp
$Comp
L Device:Varistor RV1
U 1 1 61848198
P 3350 1900
F 0 "RV1" H 3453 1946 50  0000 L CNN
F 1 "Varistor" H 3453 1855 50  0000 L CNN
F 2 "Varistor:RV_Disc_D7mm_W5.7mm_P5mm" V 3280 1900 50  0001 C CNN
F 3 "~" H 3350 1900 50  0001 C CNN
F 4 "Mouser" H 3350 1900 50  0001 C CNN "Vendor1"
F 5 "652-CV300K5BL1" H 3350 1900 50  0001 C CNN "SKU1"
	1    3350 1900
	1    0    0    -1  
$EndComp
$Comp
L Device:Fuse F1
U 1 1 6185E982
P 3050 1700
F 0 "F1" V 2853 1700 50  0000 C CNN
F 1 "Fuse" V 2944 1700 50  0000 C CNN
F 2 "Fuse:Fuseholder_Cylinder-5x20mm_Schurter_0031_8201_Horizontal_Open" V 2980 1700 50  0001 C CNN
F 3 "~" H 3050 1700 50  0001 C CNN
	1    3050 1700
	0    1    1    0   
$EndComp
$Comp
L Relay:FINDER-32.21-x000 K1
U 1 1 61864495
P 3150 2950
F 0 "K1" H 3500 2700 50  0000 C CNN
F 1 "FINDER-32.21-x000" H 3400 3300 50  0000 C CNN
F 2 "Relay_THT:Relay_SPDT_Finder_32.21-x000" H 4420 2920 50  0001 C CNN
F 3 "https://gfinder.findernet.com/assets/Series/355/S32EN.pdf" H 3150 2950 50  0001 C CNN
	1    3150 2950
	-1   0    0    -1  
$EndComp
$Comp
L Converter_ACDC:RAC01-05SGB PS1
U 1 1 6186AC4E
P 4150 1900
F 0 "PS1" H 4150 2267 50  0000 C CNN
F 1 "RAC01-05SGB" H 4150 2176 50  0000 C CNN
F 2 "Converter_ACDC:Converter_ACDC_RECOM_RAC01-xxSGB_THT" H 4150 1550 50  0001 C CNN
F 3 "https://www.recom-power.com/pdf/Powerline-AC-DC/RAC01-GB.pdf" H 4000 1900 50  0001 C CNN
F 4 "Mouser" H 4150 1900 50  0001 C CNN "Vendor1"
F 5 " 919-RAC01-05SGB" H 4150 1900 50  0001 C CNN "SKU1"
	1    4150 1900
	1    0    0    -1  
$EndComp
Text Notes 3850 2250 0    50   ~ 0
pin compatible with 3V3 etc.
$Comp
L Device:D_Small D1
U 1 1 618AA11F
P 4750 1900
F 0 "D1" V 4704 1980 50  0000 L CNN
F 1 "SMBJ7.0A" V 4795 1980 50  0000 L CNN
F 2 "Diode_SMD:D_SMB" H 4750 1900 50  0001 C CNN
F 3 "https://www.littelfuse.com/~/media/electronics/datasheets/tvs_diodes/littelfuse_tvs_diode_smbj_datasheet.pdf.pdf" H 4750 1900 50  0001 C CNN
	1    4750 1900
	0    1    1    0   
$EndComp
Text Label 8000 3000 2    50   ~ 0
A0
Text Label 8000 2900 2    50   ~ 0
A1
Text Label 8000 2800 2    50   ~ 0
A2
Text Label 8000 2700 2    50   ~ 0
A3
Text Label 8000 2600 2    50   ~ 0
A4
Text Label 8000 2500 2    50   ~ 0
A5
Text Notes 7850 2600 2    50   ~ 0
SDA
Text Notes 7850 2500 2    50   ~ 0
SCL
Text Label 8000 3100 2    50   ~ 0
AREF
Text Label 8000 2400 2    50   ~ 0
A6
Text Label 8000 2300 2    50   ~ 0
A7
Text Notes 7850 2300 2    50   ~ 0
BATT
Wire Wire Line
	8100 3350 8000 3350
Wire Wire Line
	8100 3450 8000 3450
Wire Wire Line
	8100 3550 8000 3550
Wire Wire Line
	8100 3650 8000 3650
Wire Wire Line
	8100 3750 8000 3750
Wire Wire Line
	8100 3850 8000 3850
Wire Wire Line
	8100 3950 8000 3950
Wire Wire Line
	8100 4050 8000 4050
Wire Wire Line
	8100 4150 8000 4150
Wire Wire Line
	8100 4250 8000 4250
Wire Wire Line
	8100 4350 8000 4350
Wire Wire Line
	8100 4450 8000 4450
Wire Wire Line
	8100 4550 8000 4550
Wire Wire Line
	8100 4650 8000 4650
Text Label 8000 3350 2    50   ~ 0
D0
Text Notes 7800 3350 2    50   ~ 0
RX
Text Label 8000 3450 2    50   ~ 0
D1
Text Notes 7800 3450 2    50   ~ 0
TX
Text Label 8000 3550 2    50   ~ 0
D2
Text Label 8000 3650 2    50   ~ 0
D3
Text Label 8000 3750 2    50   ~ 0
D4
Text Label 8000 3850 2    50   ~ 0
D5
Text Label 8000 3950 2    50   ~ 0
D6
Text Label 8000 4050 2    50   ~ 0
D7
Text Label 8000 4150 2    50   ~ 0
D8
Text Label 8000 4250 2    50   ~ 0
D9
Text Label 8000 4350 2    50   ~ 0
D10
Text Label 8000 4450 2    50   ~ 0
D11
Text Notes 7800 4450 2    50   ~ 0
MOSI
Text Label 8000 4550 2    50   ~ 0
D12
Text Label 8000 4650 2    50   ~ 0
D13
Text Notes 7800 4650 2    50   ~ 0
SCK
Text Notes 7800 4550 2    50   ~ 0
MISO
Text Notes 7800 4350 2    50   ~ 0
SS RF
Text Notes 7800 3550 2    50   ~ 0
IRQ
Text Notes 7800 3950 2    50   ~ 0
LED
Text Label 8000 4750 2    50   ~ 0
~RST
$Comp
L Connector_Generic:Conn_01x15 J6
U 1 1 618A297D
P 8300 4050
F 0 "J6" H 8380 4042 50  0000 L CNN
F 1 "Digital" H 8380 3951 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x15_P2.54mm_Vertical" H 8300 4050 50  0001 C CNN
F 3 "~" H 8300 4050 50  0001 C CNN
	1    8300 4050
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x15 J5
U 1 1 618A2987
P 8300 2400
F 0 "J5" H 8380 2392 50  0000 L CNN
F 1 "Analog" H 8380 2301 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x15_P2.54mm_Vertical" H 8300 2400 50  0001 C CNN
F 3 "~" H 8300 2400 50  0001 C CNN
	1    8300 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8100 1700 8050 1700
Wire Wire Line
	8100 1900 7750 1900
Wire Wire Line
	8100 2000 8000 2000
Wire Wire Line
	8100 2100 8000 2100
Wire Wire Line
	8100 2200 7750 2200
Wire Wire Line
	8100 2300 8000 2300
Wire Wire Line
	8100 2400 8000 2400
Wire Wire Line
	8100 2500 8000 2500
Wire Wire Line
	8100 2600 8000 2600
Wire Wire Line
	8100 2700 8000 2700
Wire Wire Line
	8100 2800 8000 2800
Wire Wire Line
	8100 2900 8000 2900
Wire Wire Line
	8100 3000 8000 3000
$Comp
L power:VDC #PWR0101
U 1 1 618A299E
P 7750 1700
F 0 "#PWR0101" H 7750 1600 50  0001 C CNN
F 1 "VDC" V 7750 1850 50  0000 L CNN
F 2 "" H 7750 1700 50  0001 C CNN
F 3 "" H 7750 1700 50  0001 C CNN
	1    7750 1700
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 618A29A8
P 7750 1900
F 0 "#PWR0102" H 7750 1650 50  0001 C CNN
F 1 "GND" V 7755 1772 50  0000 R CNN
F 2 "" H 7750 1900 50  0001 C CNN
F 3 "" H 7750 1900 50  0001 C CNN
	1    7750 1900
	0    1    1    0   
$EndComp
Text Label 8000 2000 2    50   ~ 0
D0
Text Notes 7850 2000 2    50   ~ 0
RX
Text Label 8000 2100 2    50   ~ 0
D1
Text Notes 7850 2100 2    50   ~ 0
TX
$Comp
L power:+3V3 #PWR0103
U 1 1 618A29BA
P 7750 2200
F 0 "#PWR0103" H 7750 2050 50  0001 C CNN
F 1 "+3V3" V 7765 2328 50  0000 L CNN
F 2 "" H 7750 2200 50  0001 C CNN
F 3 "" H 7750 2200 50  0001 C CNN
	1    7750 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8100 1800 8050 1800
Wire Wire Line
	8050 1800 8050 1700
Connection ~ 8050 1700
Wire Wire Line
	8050 1700 7750 1700
Wire Wire Line
	8100 4750 8000 4750
Wire Wire Line
	8100 3100 8000 3100
Wire Wire Line
	3750 1800 3700 1800
Wire Wire Line
	3700 1800 3700 1700
Wire Wire Line
	3700 1700 3350 1700
Wire Wire Line
	3350 1700 3350 1750
Wire Wire Line
	3750 2000 3700 2000
Wire Wire Line
	3700 2000 3700 2100
Wire Wire Line
	3700 2100 3350 2100
Wire Wire Line
	3350 2100 3350 2050
Wire Wire Line
	3200 1700 3350 1700
Connection ~ 3350 1700
Connection ~ 3350 2100
Wire Wire Line
	4550 1800 4550 1700
Wire Wire Line
	4550 1700 4750 1700
Wire Wire Line
	4750 1700 4750 1800
Wire Wire Line
	4550 2000 4550 2100
Wire Wire Line
	4550 2100 4750 2100
Wire Wire Line
	4750 2100 4750 2000
Connection ~ 4750 1700
Connection ~ 4750 2100
$Comp
L Device:CP_Small C1
U 1 1 6190C4F4
P 5300 1900
F 0 "C1" H 5388 1946 50  0000 L CNN
F 1 "68u" H 5388 1855 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 5300 1900 50  0001 C CNN
F 3 "~" H 5300 1900 50  0001 C CNN
	1    5300 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 1800 5300 1700
Wire Wire Line
	4750 1700 5300 1700
Wire Wire Line
	5300 2100 5300 2000
Wire Wire Line
	4750 2100 5300 2100
Wire Wire Line
	5300 1700 5600 1700
Connection ~ 5300 1700
$Comp
L power:GND #PWR0104
U 1 1 6191ABA5
P 5850 2150
F 0 "#PWR0104" H 5850 1900 50  0001 C CNN
F 1 "GND" V 5855 2022 50  0000 R CNN
F 2 "" H 5850 2150 50  0001 C CNN
F 3 "" H 5850 2150 50  0001 C CNN
	1    5850 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 2100 5300 2100
Connection ~ 5300 2100
$Comp
L power:VDC #PWR0105
U 1 1 6191CA3F
P 5850 1650
F 0 "#PWR0105" H 5850 1550 50  0001 C CNN
F 1 "VDC" V 5850 1800 50  0000 L CNN
F 2 "" H 5850 1650 50  0001 C CNN
F 3 "" H 5850 1650 50  0001 C CNN
	1    5850 1650
	1    0    0    -1  
$EndComp
Text Notes 4600 1650 0    50   ~ 0
5 VDC
Wire Wire Line
	2950 2100 3350 2100
Text Notes 1800 1700 0    50   ~ 0
Live
$Comp
L power:Earth_Protective #PWR0106
U 1 1 619413AD
P 1700 2550
F 0 "#PWR0106" H 1950 2300 50  0001 C CNN
F 1 "Earth_Protective" H 2150 2400 50  0001 C CNN
F 2 "" H 1700 2450 50  0001 C CNN
F 3 "~" H 1700 2450 50  0001 C CNN
	1    1700 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R1
U 1 1 61957B22
P 5600 1900
F 0 "R1" H 5659 1946 50  0000 L CNN
F 1 "NP" H 5659 1855 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" H 5600 1900 50  0001 C CNN
F 3 "~" H 5600 1900 50  0001 C CNN
	1    5600 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 1800 5600 1700
Connection ~ 5600 1700
Wire Wire Line
	5600 2000 5600 2100
Connection ~ 5600 2100
Wire Wire Line
	2950 3250 2950 3400
Wire Wire Line
	2950 3400 2650 3400
$Comp
L power:VDC #PWR0107
U 1 1 6198BF72
P 3350 2500
F 0 "#PWR0107" H 3350 2400 50  0001 C CNN
F 1 "VDC" V 3350 2650 50  0000 L CNN
F 2 "" H 3350 2500 50  0001 C CNN
F 3 "" H 3350 2500 50  0001 C CNN
	1    3350 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 2500 3350 2550
Connection ~ 3350 2550
Wire Wire Line
	3350 2550 3350 2650
Wire Wire Line
	3350 2550 3700 2550
$Comp
L Device:D_Small D4
U 1 1 619AD818
P 3700 3200
F 0 "D4" V 3650 3050 50  0000 L CNN
F 1 "SMBJ7.0A" V 3750 2800 50  0000 L CNN
F 2 "Diode_SMD:D_SMB" H 3700 3200 50  0001 C CNN
F 3 "https://www.littelfuse.com/~/media/electronics/datasheets/tvs_diodes/littelfuse_tvs_diode_smbj_datasheet.pdf.pdf" H 3700 3200 50  0001 C CNN
	1    3700 3200
	0    -1   -1   0   
$EndComp
$Comp
L Device:D_Small D3
U 1 1 619AE478
P 3700 2950
F 0 "D3" V 3654 3030 50  0000 L CNN
F 1 "SM4007" V 3745 3030 50  0000 L CNN
F 2 "Diode_SMD:D_MELF" H 3700 2950 50  0001 C CNN
F 3 "https://www.littelfuse.com/~/media/electronics/datasheets/tvs_diodes/littelfuse_tvs_diode_smbj_datasheet.pdf.pdf" H 3700 2950 50  0001 C CNN
	1    3700 2950
	0    1    1    0   
$EndComp
$Comp
L Device:D_Small D2
U 1 1 619AEF73
P 3700 2700
F 0 "D2" V 3654 2780 50  0000 L CNN
F 1 "SM4007" V 3745 2780 50  0000 L CNN
F 2 "Diode_SMD:D_MELF" H 3700 2700 50  0001 C CNN
F 3 "https://www.littelfuse.com/~/media/electronics/datasheets/tvs_diodes/littelfuse_tvs_diode_smbj_datasheet.pdf.pdf" H 3700 2700 50  0001 C CNN
	1    3700 2700
	0    1    1    0   
$EndComp
Wire Wire Line
	3700 3050 3700 3100
Wire Wire Line
	3700 2850 3700 2800
Wire Wire Line
	3700 2600 3700 2550
Wire Wire Line
	3700 3300 3700 3350
Wire Wire Line
	3700 3350 3350 3350
Wire Wire Line
	3350 3350 3350 3250
Wire Wire Line
	3350 3450 3350 3350
Connection ~ 3350 3350
Wire Wire Line
	3350 3850 3350 3900
$Comp
L power:GND #PWR0108
U 1 1 619DCC41
P 3350 3900
F 0 "#PWR0108" H 3350 3650 50  0001 C CNN
F 1 "GND" V 3355 3772 50  0000 R CNN
F 2 "" H 3350 3900 50  0001 C CNN
F 3 "" H 3350 3900 50  0001 C CNN
	1    3350 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 3650 3700 3650
$Comp
L Device:R_Small R2
U 1 1 619E200F
P 3800 3650
F 0 "R2" V 4000 3600 50  0000 L CNN
F 1 "3k01" V 3900 3550 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" H 3800 3650 50  0001 C CNN
F 3 "~" H 3800 3650 50  0001 C CNN
	1    3800 3650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3900 3650 4000 3650
$Comp
L Device:Q_NPN_BEC Q1
U 1 1 619EC41C
P 3450 3650
F 0 "Q1" H 3641 3696 50  0000 L CNN
F 1 "BC847" H 3641 3605 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3650 3750 50  0001 C CNN
F 3 "http://www.infineon.com/dgdl/Infineon-BC847SERIES_BC848SERIES_BC849SERIES_BC850SERIES-DS-v01_01-en.pdf?fileId=db3a304314dca389011541d4630a1657" H 3450 3650 50  0001 C CNN
	1    3450 3650
	-1   0    0    -1  
$EndComp
Text Label 4000 3650 0    50   ~ 0
D3
Text Notes 7800 3650 2    50   ~ 0
Switch 1
Text Notes 1800 1900 0    50   ~ 0
Switch 1
Text Notes 1800 2100 0    50   ~ 0
Switch 2
Wire Wire Line
	1650 1700 2200 1700
Wire Wire Line
	2650 3400 2650 1700
Connection ~ 2650 1700
Wire Wire Line
	2650 1700 2900 1700
$Comp
L Relay:FINDER-32.21-x000 K2
U 1 1 61A61C61
P 2700 4650
F 0 "K2" H 3050 4400 50  0000 C CNN
F 1 "FINDER-32.21-x000" H 2950 5000 50  0000 C CNN
F 2 "Relay_THT:Relay_SPDT_Finder_32.21-x000" H 3970 4620 50  0001 C CNN
F 3 "https://gfinder.findernet.com/assets/Series/355/S32EN.pdf" H 2700 4650 50  0001 C CNN
	1    2700 4650
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2500 4950 2500 5100
Wire Wire Line
	2500 5100 2200 5100
$Comp
L power:VDC #PWR0109
U 1 1 61A61EE3
P 2900 4200
F 0 "#PWR0109" H 2900 4100 50  0001 C CNN
F 1 "VDC" V 2900 4350 50  0000 L CNN
F 2 "" H 2900 4200 50  0001 C CNN
F 3 "" H 2900 4200 50  0001 C CNN
	1    2900 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 4200 2900 4250
Connection ~ 2900 4250
Wire Wire Line
	2900 4250 2900 4350
Wire Wire Line
	2900 4250 3250 4250
$Comp
L Device:D_Small D7
U 1 1 61A61EF1
P 3250 4900
F 0 "D7" V 3200 4750 50  0000 L CNN
F 1 "SMBJ7.0A" V 3300 4500 50  0000 L CNN
F 2 "Diode_SMD:D_SMB" H 3250 4900 50  0001 C CNN
F 3 "https://www.littelfuse.com/~/media/electronics/datasheets/tvs_diodes/littelfuse_tvs_diode_smbj_datasheet.pdf.pdf" H 3250 4900 50  0001 C CNN
	1    3250 4900
	0    -1   -1   0   
$EndComp
$Comp
L Device:D_Small D6
U 1 1 61A61EFB
P 3250 4650
F 0 "D6" V 3204 4730 50  0000 L CNN
F 1 "SM4007" V 3295 4730 50  0000 L CNN
F 2 "Diode_SMD:D_MELF" H 3250 4650 50  0001 C CNN
F 3 "https://www.littelfuse.com/~/media/electronics/datasheets/tvs_diodes/littelfuse_tvs_diode_smbj_datasheet.pdf.pdf" H 3250 4650 50  0001 C CNN
	1    3250 4650
	0    1    1    0   
$EndComp
$Comp
L Device:D_Small D5
U 1 1 61A61F05
P 3250 4400
F 0 "D5" V 3204 4480 50  0000 L CNN
F 1 "SM4007" V 3295 4480 50  0000 L CNN
F 2 "Diode_SMD:D_MELF" H 3250 4400 50  0001 C CNN
F 3 "https://www.littelfuse.com/~/media/electronics/datasheets/tvs_diodes/littelfuse_tvs_diode_smbj_datasheet.pdf.pdf" H 3250 4400 50  0001 C CNN
	1    3250 4400
	0    1    1    0   
$EndComp
Wire Wire Line
	3250 4750 3250 4800
Wire Wire Line
	3250 4550 3250 4500
Wire Wire Line
	3250 4300 3250 4250
Wire Wire Line
	3250 5000 3250 5050
Wire Wire Line
	3250 5050 2900 5050
Wire Wire Line
	2900 5050 2900 4950
Wire Wire Line
	2900 5150 2900 5050
Connection ~ 2900 5050
Wire Wire Line
	2900 5550 2900 5600
$Comp
L power:GND #PWR0110
U 1 1 61A61F18
P 2900 5600
F 0 "#PWR0110" H 2900 5350 50  0001 C CNN
F 1 "GND" V 2905 5472 50  0000 R CNN
F 2 "" H 2900 5600 50  0001 C CNN
F 3 "" H 2900 5600 50  0001 C CNN
	1    2900 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3200 5350 3250 5350
$Comp
L Device:R_Small R3
U 1 1 61A61F23
P 3350 5350
F 0 "R3" V 3550 5300 50  0000 L CNN
F 1 "3k01" V 3450 5250 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" H 3350 5350 50  0001 C CNN
F 3 "~" H 3350 5350 50  0001 C CNN
	1    3350 5350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3450 5350 3550 5350
$Comp
L Device:Q_NPN_BEC Q2
U 1 1 61A61F2E
P 3000 5350
F 0 "Q2" H 3191 5396 50  0000 L CNN
F 1 "BC847" H 3191 5305 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3200 5450 50  0001 C CNN
F 3 "http://www.infineon.com/dgdl/Infineon-BC847SERIES_BC848SERIES_BC849SERIES_BC850SERIES-DS-v01_01-en.pdf?fileId=db3a304314dca389011541d4630a1657" H 3000 5350 50  0001 C CNN
	1    3000 5350
	-1   0    0    -1  
$EndComp
Text Label 3550 5350 0    50   ~ 0
D4
Wire Wire Line
	2200 1700 2200 5100
Connection ~ 2200 1700
Wire Wire Line
	2200 1700 2650 1700
Text Notes 7800 3750 2    50   ~ 0
Switch 2
Wire Wire Line
	1650 2300 1700 2300
Wire Wire Line
	1700 2300 1700 2400
Wire Wire Line
	1650 2400 1700 2400
Connection ~ 1700 2400
Wire Wire Line
	1700 2400 1700 2550
Wire Wire Line
	2950 2100 2950 2000
Wire Wire Line
	2950 1800 1650 1800
Wire Wire Line
	1650 1900 2850 1900
Connection ~ 2950 2000
Wire Wire Line
	2950 2000 2950 1800
Text Notes 1800 1800 0    50   ~ 0
Neutral
Text Notes 1800 2000 0    50   ~ 0
Neutral
Wire Wire Line
	1650 2000 2950 2000
Wire Wire Line
	2850 2650 2850 1900
Wire Wire Line
	2400 4350 2400 2100
Wire Wire Line
	2400 2100 1650 2100
Text Notes 1800 2200 0    50   ~ 0
Neutral
Wire Wire Line
	1650 2200 2950 2200
Wire Wire Line
	2950 2200 2950 2100
Connection ~ 2950 2100
$Comp
L Connector_Generic:Conn_01x03 J2
U 1 1 61B5F50A
P 6400 1900
F 0 "J2" H 6480 1942 50  0000 L CNN
F 1 "DC" H 6480 1851 50  0000 L CNN
F 2 "Connector_Wire:SolderWire-0.75sqmm_1x03_P4.8mm_D1.25mm_OD2.3mm" H 6400 1900 50  0001 C CNN
F 3 "~" H 6400 1900 50  0001 C CNN
	1    6400 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 1800 5850 1800
Wire Wire Line
	5850 1800 5850 1700
Wire Wire Line
	5850 1700 5600 1700
Wire Wire Line
	6200 2000 5850 2000
Wire Wire Line
	5850 2000 5850 2100
Wire Wire Line
	5850 2100 5600 2100
Wire Wire Line
	5850 1700 5850 1650
Connection ~ 5850 1700
Wire Wire Line
	5850 2100 5850 2150
Connection ~ 5850 2100
$Comp
L Connector_Generic:Conn_01x02 J3
U 1 1 61B80611
P 6400 2600
F 0 "J3" H 6480 2592 50  0000 L CNN
F 1 "External button 1" H 6480 2501 50  0000 L CNN
F 2 "Connector_Wire:SolderWire-0.75sqmm_1x02_P4.8mm_D1.25mm_OD2.3mm" H 6400 2600 50  0001 C CNN
F 3 "~" H 6400 2600 50  0001 C CNN
	1    6400 2600
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J4
U 1 1 61B8195A
P 6400 3250
F 0 "J4" H 6480 3242 50  0000 L CNN
F 1 "External button 2" H 6480 3151 50  0000 L CNN
F 2 "Connector_Wire:SolderWire-0.75sqmm_1x02_P4.8mm_D1.25mm_OD2.3mm" H 6400 3250 50  0001 C CNN
F 3 "~" H 6400 3250 50  0001 C CNN
	1    6400 3250
	1    0    0    -1  
$EndComp
Text Notes 7800 4050 2    50   ~ 0
~External button 1
Text Notes 7800 4150 2    50   ~ 0
~External button 2
Text Notes 7800 4250 2    50   ~ 0
SS external
Wire Wire Line
	5650 3250 6200 3250
Wire Wire Line
	5650 2600 6200 2600
$Comp
L Device:CP_Small C3
U 1 1 61DC5A6F
P 5300 3400
F 0 "C3" H 5388 3446 50  0000 L CNN
F 1 "68u" H 5388 3355 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 5300 3400 50  0001 C CNN
F 3 "~" H 5300 3400 50  0001 C CNN
	1    5300 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:CP_Small C2
U 1 1 61DC4966
P 5300 2750
F 0 "C2" H 5388 2796 50  0000 L CNN
F 1 "68u" H 5388 2705 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 5300 2750 50  0001 C CNN
F 3 "~" H 5300 2750 50  0001 C CNN
	1    5300 2750
	1    0    0    -1  
$EndComp
Connection ~ 5300 3250
Wire Wire Line
	5450 3250 5300 3250
Connection ~ 5300 2600
Wire Wire Line
	5450 2600 5300 2600
$Comp
L Device:R_Small R5
U 1 1 61D81978
P 5550 3250
F 0 "R5" V 5354 3250 50  0000 C CNN
F 1 "1k" V 5445 3250 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" H 5550 3250 50  0001 C CNN
F 3 "~" H 5550 3250 50  0001 C CNN
	1    5550 3250
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R4
U 1 1 61D7FCE1
P 5550 2600
F 0 "R4" V 5354 2600 50  0000 C CNN
F 1 "1k" V 5445 2600 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" H 5550 2600 50  0001 C CNN
F 3 "~" H 5550 2600 50  0001 C CNN
	1    5550 2600
	0    1    1    0   
$EndComp
Wire Wire Line
	6000 3750 6000 3700
Connection ~ 6000 3700
Connection ~ 5950 3550
Wire Wire Line
	5950 3700 6000 3700
Wire Wire Line
	5950 3550 5950 3700
Connection ~ 6050 2900
Wire Wire Line
	6050 3700 6000 3700
Wire Wire Line
	6050 2900 6050 3700
Wire Wire Line
	5200 3250 5300 3250
Wire Wire Line
	5300 3550 5300 3500
Wire Wire Line
	5950 3550 5300 3550
Wire Wire Line
	5950 3350 5950 3550
Wire Wire Line
	6200 3350 5950 3350
Wire Wire Line
	5300 3300 5300 3250
Wire Wire Line
	5300 2900 5300 2850
Wire Wire Line
	6050 2900 5300 2900
Wire Wire Line
	6050 2700 6050 2900
Wire Wire Line
	6200 2700 6050 2700
Wire Wire Line
	5300 2600 5200 2600
Wire Wire Line
	5300 2650 5300 2600
Text Label 5200 3250 2    50   ~ 0
D8
Text Label 5200 2600 2    50   ~ 0
D7
$Comp
L power:GND #PWR0111
U 1 1 61B8449E
P 6000 3750
F 0 "#PWR0111" H 6000 3500 50  0001 C CNN
F 1 "GND" V 6005 3622 50  0000 R CNN
F 2 "" H 6000 3750 50  0001 C CNN
F 3 "" H 6000 3750 50  0001 C CNN
	1    6000 3750
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0112
U 1 1 61E72BC7
P 6150 1900
F 0 "#PWR0112" H 6150 1750 50  0001 C CNN
F 1 "+3V3" V 6165 2028 50  0000 L CNN
F 2 "" H 6150 1900 50  0001 C CNN
F 3 "" H 6150 1900 50  0001 C CNN
	1    6150 1900
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6150 1900 6200 1900
Text Label 9600 3000 2    50   ~ 0
A0
Text Label 9600 2900 2    50   ~ 0
A1
Text Label 9600 2800 2    50   ~ 0
A2
Text Label 9600 2700 2    50   ~ 0
A3
Text Label 9600 2600 2    50   ~ 0
A4
Text Label 9600 2500 2    50   ~ 0
A5
Text Notes 9450 2600 2    50   ~ 0
SDA
Text Notes 9450 2500 2    50   ~ 0
SCL
Text Label 9600 3100 2    50   ~ 0
AREF
Text Label 9600 2400 2    50   ~ 0
A6
Text Label 9600 2300 2    50   ~ 0
A7
Text Notes 9450 2300 2    50   ~ 0
BATT
$Comp
L Connector_Generic:Conn_01x15 J7
U 1 1 61EE0789
P 9900 2400
F 0 "J7" H 9980 2392 50  0000 L CNN
F 1 "Analog breakout" H 9980 2301 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x15_P2.54mm_Vertical" H 9900 2400 50  0001 C CNN
F 3 "~" H 9900 2400 50  0001 C CNN
	1    9900 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9700 1700 9650 1700
Wire Wire Line
	9700 1900 9350 1900
Wire Wire Line
	9700 2000 9600 2000
Wire Wire Line
	9700 2100 9600 2100
Wire Wire Line
	9700 2200 9350 2200
Wire Wire Line
	9700 2300 9600 2300
Wire Wire Line
	9700 2400 9600 2400
Wire Wire Line
	9700 2500 9600 2500
Wire Wire Line
	9700 2600 9600 2600
Wire Wire Line
	9700 2700 9600 2700
Wire Wire Line
	9700 2800 9600 2800
Wire Wire Line
	9700 2900 9600 2900
Wire Wire Line
	9700 3000 9600 3000
$Comp
L power:VDC #PWR0113
U 1 1 61EE07A0
P 9350 1700
F 0 "#PWR0113" H 9350 1600 50  0001 C CNN
F 1 "VDC" V 9350 1850 50  0000 L CNN
F 2 "" H 9350 1700 50  0001 C CNN
F 3 "" H 9350 1700 50  0001 C CNN
	1    9350 1700
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0114
U 1 1 61EE07AA
P 9350 1900
F 0 "#PWR0114" H 9350 1650 50  0001 C CNN
F 1 "GND" V 9355 1772 50  0000 R CNN
F 2 "" H 9350 1900 50  0001 C CNN
F 3 "" H 9350 1900 50  0001 C CNN
	1    9350 1900
	0    1    1    0   
$EndComp
Text Label 9600 2000 2    50   ~ 0
D0
Text Notes 9450 2000 2    50   ~ 0
RX
Text Label 9600 2100 2    50   ~ 0
D1
Text Notes 9450 2100 2    50   ~ 0
TX
$Comp
L power:+3V3 #PWR0115
U 1 1 61EE07B8
P 9350 2200
F 0 "#PWR0115" H 9350 2050 50  0001 C CNN
F 1 "+3V3" V 9365 2328 50  0000 L CNN
F 2 "" H 9350 2200 50  0001 C CNN
F 3 "" H 9350 2200 50  0001 C CNN
	1    9350 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9700 1800 9650 1800
Wire Wire Line
	9650 1800 9650 1700
Connection ~ 9650 1700
Wire Wire Line
	9650 1700 9350 1700
Wire Wire Line
	9700 3100 9600 3100
Wire Wire Line
	9700 3350 9600 3350
Wire Wire Line
	9700 3450 9600 3450
Wire Wire Line
	9700 3550 9600 3550
Wire Wire Line
	9700 3650 9600 3650
Wire Wire Line
	9700 3750 9600 3750
Wire Wire Line
	9700 3850 9600 3850
Wire Wire Line
	9700 3950 9600 3950
Wire Wire Line
	9700 4050 9600 4050
Wire Wire Line
	9700 4150 9600 4150
Wire Wire Line
	9700 4250 9600 4250
Wire Wire Line
	9700 4350 9600 4350
Wire Wire Line
	9700 4450 9600 4450
Wire Wire Line
	9700 4550 9600 4550
Wire Wire Line
	9700 4650 9600 4650
Text Label 9600 3350 2    50   ~ 0
D0
Text Notes 9400 3350 2    50   ~ 0
RX
Text Label 9600 3450 2    50   ~ 0
D1
Text Notes 9400 3450 2    50   ~ 0
TX
Text Label 9600 3550 2    50   ~ 0
D2
Text Label 9600 3650 2    50   ~ 0
D3
Text Label 9600 3750 2    50   ~ 0
D4
Text Label 9600 3850 2    50   ~ 0
D5
Text Label 9600 3950 2    50   ~ 0
D6
Text Label 9600 4050 2    50   ~ 0
D7
Text Label 9600 4150 2    50   ~ 0
D8
Text Label 9600 4250 2    50   ~ 0
D9
Text Label 9600 4350 2    50   ~ 0
D10
Text Label 9600 4450 2    50   ~ 0
D11
Text Notes 9400 4450 2    50   ~ 0
MOSI
Text Label 9600 4550 2    50   ~ 0
D12
Text Label 9600 4650 2    50   ~ 0
D13
Text Notes 9400 4650 2    50   ~ 0
SCK
Text Notes 9400 4550 2    50   ~ 0
MISO
Text Notes 9400 4350 2    50   ~ 0
SS RF
Text Notes 9400 3550 2    50   ~ 0
IRQ
Text Notes 9400 3950 2    50   ~ 0
LED
Text Label 9600 4750 2    50   ~ 0
~RST
$Comp
L Connector_Generic:Conn_01x15 J8
U 1 1 61EF3292
P 9900 4050
F 0 "J8" H 9980 4042 50  0000 L CNN
F 1 "Digital breakout" H 9980 3951 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x15_P2.54mm_Vertical" H 9900 4050 50  0001 C CNN
F 3 "~" H 9900 4050 50  0001 C CNN
	1    9900 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	9700 4750 9600 4750
Text Notes 9400 3650 2    50   ~ 0
Switch 1
Text Notes 9400 3750 2    50   ~ 0
Switch 2
Text Notes 9400 4050 2    50   ~ 0
~External button 1
Text Notes 9400 4150 2    50   ~ 0
~External button 2
Text Notes 9400 4250 2    50   ~ 0
SS external
NoConn ~ 3050 2650
NoConn ~ 2600 4350
$Comp
L Mechanical:MountingHole H1
U 1 1 620A5880
P 4650 5800
F 0 "H1" H 4750 5846 50  0000 L CNN
F 1 "MountingHole" H 4750 5755 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 4650 5800 50  0001 C CNN
F 3 "~" H 4650 5800 50  0001 C CNN
	1    4650 5800
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 620A68B2
P 4650 6050
F 0 "H2" H 4750 6096 50  0000 L CNN
F 1 "MountingHole" H 4750 6005 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 4650 6050 50  0001 C CNN
F 3 "~" H 4650 6050 50  0001 C CNN
	1    4650 6050
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 620B1E95
P 4650 6300
F 0 "H3" H 4750 6346 50  0000 L CNN
F 1 "MountingHole" H 4750 6255 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 4650 6300 50  0001 C CNN
F 3 "~" H 4650 6300 50  0001 C CNN
	1    4650 6300
	1    0    0    -1  
$EndComp
$EndSCHEMATC
