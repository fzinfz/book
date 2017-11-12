<!-- TOC -->

- [Endianness](#endianness)
- [Power Connectors](#power-connectors)
    - [Industrial](#industrial)
- [UPS](#ups)
    - [Offline/standby](#offlinestandby)
    - [Line-interactive](#line-interactive)
    - [Online/double-conversion](#onlinedouble-conversion)
- [Raspberry PI](#raspberry-pi)
    - [Console](#console)
- [RS232 3pin](#rs232-3pin)

<!-- /TOC -->

# Endianness
https://www.cs.umd.edu/class/sum2003/cmsc311/Notes/Data/endian.html
In big endian, you store the most significant byte(MSB) in the smallest address.  
In little endian, you store the least significant byte(LSB) in the smallest address

# Power Connectors
https://en.wikipedia.org/wiki/IEC_60320#Appliance_couplers  
C13/C14 and C15/C16 connectors for up to 15 A[10] (IEC maximum is 10 A)  
C15/C16's temperature rating is 120 °C rather than the 70 °C of the similar C13/C14 combination.  
C19/C20 and C21/C22 connectors for up to 20 A[11] (IEC maximum is 16 A)

https://en.wikipedia.org/wiki/NEMA_connector
![](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/NEMA_simplified_pins.svg/525px-NEMA_simplified_pins.svg.png)

## Industrial
https://en.wikipedia.org/wiki/Industrial_and_multiphase_power_plugs_and_sockets

# UPS
## Offline/standby
![](https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Standby_UPS_Diagram_SVG.svg/525px-Standby_UPS_Diagram_SVG.svg.png)

## Line-interactive
![](https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Line-Interactive_UPS_Diagram_SVG.svg/750px-Line-Interactive_UPS_Diagram_SVG.svg.png)

## Online/double-conversion
the batteries are always connected to the inverter

# Raspberry PI
```
/opt/vc/bin/vcgencmd measure_temp
```
## Console
/dev/ttyAMA0
```
Speed (baud rate): 115200
Bits: 8
Parity: None
Stop Bits: 1
Flow Control: None
```

# RS232 3pin
[RS232簡單接法(3線)](http://flykof.pixnet.net/blog/post/24074586-rs232%E7%B0%A1%E5%96%AE%E6%8E%A5%E6%B3%95(3%E7%B7%9A))  
![](https://pic.pimg.tw/flykof/4a729ba808337.jpg)

