- [Pinout](#pinout)
- [Uno](#uno)
    - [Q](#q)
    - [R3](#r3)
- [OLED](#oled)
    - [IDE](#ide)
- [3D Case](#3d-case)


# Pinout
| Feature | GPIO (General-Purpose I/O) | PWM (Pulse Width Modulation) | ADC (Analog-to-Digital Converter) |
| :--- | :--- | :--- | :--- |
| **Input/Output** | Both **Input** and **Output**. | **Output** only. | **Input** only. |
| **Arduino Function**| `pinMode()`, `digitalWrite()`, `digitalRead()` | `analogWrite()` | `analogRead()` |
| **Mark** | D_ | ~D_ | A_ |

AREF: http://tronixstuff.com/2013/12/12/arduino-tutorials-chapter-22-aref-pin/

# Uno
https://www.arduino.cc/en/hardware/#uno-family

## Q
- Debian-capable
- Qualcomm QRB2210 microprocessor (MPU), quad-core 2.0 GHz CPU
- real-time STM32U585 microcontroller (MCU)
- RAM: 2GB LPDDR4
- Storage: 16 GB eMMC built-in (no SD card required)

## R3
Atmel AVR ATmega328P | 8-bit RISC | 16MIPS throughput at 16MHz
- https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf

https://store-usa.arduino.cc/products/arduino-uno-rev3  
- INPUT VOLTAGE (LIMIT)	6-20V limit / 7-12V recommended
- DC CURRENT PER I/O PIN	20 mA  

https://content.arduino.cc/assets/A000066-pinout.png
- 14 digital input/output pins (of which 6 can be used as PWM outputs)
- 6 analog inputs

# OLED
- I2C: 100Khz - 3.4Mhz, many devices on the same bus
- SPI: 4Mhz and up to 100Mhz

## IDE
- Sketch Menu -> Include Library -> Manage Libraries
   - Search: `BusIO` + `adafruit ssd1306`
- File -> Examples

SSD1306 Oled display: https://create.arduino.cc/projecthub/Arnov_Sharma_makes/0-96-inch-oled-getting-started-guide-78163a

    // Declaration for an SSD1306 display connected to I2C (SDA, SCL pins)
    // The pins for I2C are defined by the Wire-library. 
    // On an arduino UNO:       A4(SDA), A5(SCL)
    // On an arduino MEGA 2560: 20(SDA), 21(SCL)
    // On an arduino LEONARDO:   2(SDA),  3(SCL), ...

- File -> Examples ---> ssd1306_128x32_spi

```
    // Declaration for SSD1306 display connected using software SPI (default case)
    #define OLED_MOSI   9
    #define OLED_CLK   10
    #define OLED_DC    11
    #define OLED_CS    12
    #define OLED_RESET 13
```

# 3D Case
Pro Mini | Wall | https://www.thingiverse.com/thing:2457807