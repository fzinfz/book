

https://www.arduino.cc/en/Products.Compare  
http://tronixstuff.com/2013/12/12/arduino-tutorials-chapter-22-aref-pin/

# Uni R3
https://store-usa.arduino.cc/products/arduino-uno-rev3  
INPUT VOLTAGE (LIMIT)	6-20V 、 7-12V  
DC CURRENT PER I/O PIN	20 mA  
![](https://content.arduino.cc/assets/A000066-pinout.png)

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

    // Declaration for SSD1306 display connected using software SPI (default case):
    #define OLED_MOSI   9
    #define OLED_CLK   10
    #define OLED_DC    11
    #define OLED_CS    12
    #define OLED_RESET 13

# Cases
Pro Mini Mount: https://www.thingiverse.com/thing:2457807