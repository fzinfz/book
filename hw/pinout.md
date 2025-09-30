<!-- TOC -->

- [RS232](#rs232)
- [RS485](#rs485)
- [USB3](#usb3)
    - [Type-C](#type-c)
- [PCI-E](#pci-e)
- [HMDI](#hmdi)
    - [19 Pins](#19-pins)
- [Channel](#channel)
- [DVI/HMDI](#dvihmdi)

<!-- /TOC -->

# RS232
[RS232簡單接法(3線)](http://flykof.pixnet.net/blog/post/24074586-rs232%E7%B0%A1%E5%96%AE%E6%8E%A5%E6%B3%95(3%E7%B7%9A))  
![](https://pic.pimg.tw/flykof/4a729ba808337.jpg)

# RS485 
Line Termination Resistor Calculator: http://www.alciro.org/tools/RS-485/RS485-resistor-termination-calculator.jsp

# USB3
VBUS/GND: shared by USB2/3; D-/D+: USB2 only.

![](https://imgur.com/Z8covNr.png)  
https://en.wikipedia.org/wiki/USB_3.0  

![](https://upload.wikimedia.org/wikipedia/commons/8/82/USB_2.0_and_3.0_connectors.svg)

## Type-C 
- Receptacles: 12+12 Pins
- Plugs: 12+10 Pins: B6/7 n/a & CC2 -> VCONN

| Pin |      Name       |                     Description                     |
|-----|-----------------|-----------------------------------------------------|
| A1/B12  |       GND       |                    Ground return                    |
| A2  | SSTXp1 ("TX1+") | SuperSpeed differential pair #1, transmit, positive |
| A3  | SSTXn1 ("TX1−") | SuperSpeed differential pair #1, transmit, negative |
| A4  |      VBUS       |                      Bus power                      |
| A5  |       CC1       |                Configuration channel                |
| A6  |       D+        |   USB 2.0 differential pair, position 1, positive   |
| A7  |       D−        |   USB 2.0 differential pair, position 1, negative   |
| A8  |      SBU1       |                 Sideband use (SBU)                  |
| A9  |      VBUS       |                      Bus power                      |
| A10 | SSRXn2 ("RX2−") | SuperSpeed differential pair #4, receive, negative  |
| A11 | SSRXp2 ("RX2+") | SuperSpeed differential pair #4, receive, positive  |
| A12 |       GND       |                    Ground return                    |

# PCI-E
https://en.wikipedia.org/wiki/PCI_Express#Pinout  

    side A: PRSNT1# shorter than the rest | side B: component side
    ×1/4/8/16 cards end at pin 18/32/49/82  
    +12 V power: 75 W (6-pin) or 150 W (8-pin) | 300 W total (2 × 75 W + 1 × 150 W)

![](https://imgur.com/u3rUvyL)


# HMDI
https://en.wikipedia.org/wiki/HDMI

Type | Name | -
--- | --- | ---
A | Std
C | Mini
D | Micro
E | Automotive | locking

## 19 Pins

    Pin 17	Ground for ARC, CEC, DDC and HEC
    Pin 18	+5 V (up to 50 mA)

    Pin 1	TMDS data 2 (+)
    Pin 2	TMDS data 2 ground
    Pin 3	TMDS data 2 (−)

    Pin 4	TMDS data 1 (+)
    Pin 5	TMDS data 1 ground
    Pin 6	TMDS data 1 (−)

    Pin 7	TMDS data 0 (+)
    Pin 8	TMDS data 0 ground
    Pin 9	TMDS data 0 (−)

    Pin 10	TMDS clock (+)
    Pin 11	TMDS clock ground
    Pin 12	TMDS clock (−)

    Pin 15	SCL (I2C clock for DDC)
    Pin 16	SDA (I2C data for DDC)

    Pin 13	CEC / Consumer Electronic Control

    Pin 14
            HDMI 1.0–1.3a: Unused
            HDMI 1.4+: ARC (+) or HEC (+)
    Pin 19
            All versions: Hot plug detect
            HDMI 1.4+: ARC (−) or HEC (−)

# Channel
- Audio Return Channel (ARC): supports stereo PCM
- HDMI Ethernet Channel (HEC): IP-based @ 100 Mbit/s

# DVI/HMDI
DVI: http://www.alciro.org/alciro/conectores_26/conector-DVI-interfaz-visual-digital_269_en.htm

    C1	Red analog	
    C2	Green analog	
    C3	Blue analog	
    C4	Analog horizontal sync	
    C5	Ground (analog)	Return for analog signals

HDMI to DVI-D: http://www.alciro.org/alciro/conectores_26/patillas-cable-HDMI-a-DVI-D_274_en.htm

