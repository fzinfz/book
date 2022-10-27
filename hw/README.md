<!-- TOC -->

- [CPU](#cpu)
- [Endianness](#endianness)
- [Protection ring](#protection-ring)
- [UEFI Shell](#uefi-shell)
- [Buses](#buses)
- [Infini Band](#infini-band)
- [Raspberry PI](#raspberry-pi)
  - [Console](#console)
- [Resolution](#resolution)

<!-- /TOC -->

# CPU
CPUID to arch: https://github.com/mer-tools/oprofile/blob/master/libop/op_hw_specific.h#L119  
CPU flags meaning: http://unix.stackexchange.com/questions/43539/what-do-the-flags-in-proc-cpuinfo-mean  

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
