<!-- TOC -->

- [Endianness](#endianness)
- [Protection ring](#protection-ring)
- [UEFI Shell](#uefi-shell)
- [CPU](#cpu)
- [GPU - AMD](#gpu---amd)
- [Buses](#buses)
- [Bluetooth](#bluetooth)
- [Infini Band](#infini-band)
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

# Buses
VESA (Video Electronics Standards Association)

https://en.wikipedia.org/wiki/List_of_device_bit_rates

|Technology|Rate||Year|
|---|---|---|
|ISA 16-Bit/8.33 MHz|66.7 Mbit/s|8.33 MB/s|1984 (created)|
|I²C|3.4 Mbit/s|425 kB/s|1992 (standardized)|
|Low Pin Count|125 Mbit/s|15.63 MB/s [x]|2002|
|HyperTransport 3.1 (3.2 GHz, 32-pair)|409.6 Gbit/s|51.2 GB/s|2008|
|Unified Media Interface 2.0 (UMI 2.0; ×4 link)|20 Gbit/s|2 GB/s [z]|2012|
|Direct Media Interface 3.0 (DMI 3.0; ×4 link)|40 Gbit/s|4 GB/s [z]|2015|
|AGP 8×|17.066 Gbit/s|2.133 GB/s|2002|
|AGP 8× 64-bit|34.133 Gbit/s|4.266 GB/s||
|PCI 32-bit/66 MHz|2.133 Gbit/s|266.7 MB/s|1995|
|PCI 64-bit/100 MHz|6.4 Gbit/s|800 MB/s||
|PCI-X QDR|34.133 Gbit/s|4.266 GB/s||
|PCI Express 2.0 (×32 link)[43]|160 Gbit/s|16 GB/s [z]|2007|
|PCI Express 3.0 (×32 link)[44]|256 Gbit/s|31.51 GB/s [y]|2011|
|QPI (9.6GT/s, 4.8 GHz)|307.2 Gbit/s|38.4 GB/s|2014|

https://en.wikipedia.org/wiki/NVLink

# Bluetooth
|Technology|Rate||Year|
|---|---|---|
|Bluetooth 2.0+EDR|3 Mbit/s|375 kB/s|2004|
|Bluetooth 3.0|25 Mbit/s|3.125 MB/s|2009|
|Bluetooth 4.0|25 Mbit/s|3.125 MB/s|2010|
|Bluetooth 5.0|50 Mbit/s|6.25 MB/s|2016|

# Infini Band
https://en.wikipedia.org/wiki/InfiniBand

| |SDR|DDR|QDR|FDR10|FDR|EDR|HDR|NDR|XDR|
|---|---|---|---|---|---|---|---|---|---|
|Signaling rate (Gbit/s)|2.5|5|10|10.3125|14.0625[6]|25.78125|50|100|250|
|Theoretical effective throughput, Gbs, per 1x[7]|2|4|8|10|13.64|25|50|||
|Speeds for 12x links (Gbit/s)|24|48|96|120|163.64|300|600|||
|Encoding (bits)|8/10|8/10|8/10|64/66|64/66|64/66|64/66|||
|Adapter latency (microseconds)[8]|5|2.5|1.3|0.7|0.7|0.5||||
|Year[9]|2001,2003|2005|2007|2011|2011|2014[7]|2017[7]|after 2020|future|

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
