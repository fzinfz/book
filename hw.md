<!-- TOC -->

- [Endianness](#endianness)
- [Protection ring](#protection-ring)
- [UEFI Shell](#uefi-shell)
- [CPU](#cpu)
- [GPU - AMD](#gpu---amd)
- [Power Connectors](#power-connectors)
    - [Industrial](#industrial)
- [UPS](#ups)
    - [Offline/standby](#offlinestandby)
    - [Line-interactive](#line-interactive)
    - [Online/double-conversion](#onlinedouble-conversion)
- [Raspberry PI](#raspberry-pi)
    - [Console](#console)
- [Arduino](#arduino)
    - [Tutorials](#tutorials)
- [RS232 3pin](#rs232-3pin)
- [Resolution](#resolution)

<!-- /TOC -->

# Endianness
https://www.cs.umd.edu/class/sum2003/cmsc311/Notes/Data/endian.html  
In big endian, you store the most significant byte(MSB) in the smallest address.  
In little endian, you store the least significant byte(LSB) in the smallest address

# Protection ring
![](https://en.wikipedia.org/wiki/File:Priv_rings.svg)

# UEFI Shell
https://software.intel.com/en-us/articles/uefi-shell

    map # list disks
    help bcfg

# CPU
CPUID to arch: https://github.com/mer-tools/oprofile/blob/master/libop/op_hw_specific.h#L119  
CPU flags meaning: http://unix.stackexchange.com/questions/43539/what-do-the-flags-in-proc-cpuinfo-mean  

# GPU - AMD
https://en.wikipedia.org/wiki/List_of_AMD_graphics_processing_units#API_Overview

Vulkan is a low-overhead, cross-platform 3D graphics and compute API.  
its predecessor: OpenGL  
supported since Graphics Core Next (Southern Islands) 1

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
https://youtu.be/Fj7e3WGUKO8?t=521  
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

# Arduino
https://www.arduino.cc/en/Products.Compare

## Tutorials
http://tronixstuff.com/2013/12/12/arduino-tutorials-chapter-22-aref-pin/

# RS232 3pin
[RS232簡單接法(3線)](http://flykof.pixnet.net/blog/post/24074586-rs232%E7%B0%A1%E5%96%AE%E6%8E%A5%E6%B3%95(3%E7%B7%9A))  
![](https://pic.pimg.tw/flykof/4a729ba808337.jpg)

# Resolution

    SQCIF = 128x96
    QCIF = 176x144
    QVGA = 320x240
    CIF = 352x240/288
    HVGA = 640x240
    VGA = 640x480
    2 CIF = 704x240/288
    4 CIF = 704x480/576
    D1 CROPPED = 704x480/576
    D1 = 720x480/576

    D1 (525) 720 x 480 is in NTSC
    D1 (625) 720 x 576 is in PAL

    720p is 1280 x 720. (921,600 total pixels)
    1080p is 1920x1080. (2,073,600 total pixels)
    3MP is 2048 x 1536. (3,145,728 total pixels)
    5MP is 2560 x 1920. (4,915,200 total pixels)
