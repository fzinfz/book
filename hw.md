<!-- TOC -->

- [[Pinout Images](http://fromwiz.com/share/s/2NJIcl1P6QOm2N7FoF15BJa90KkA5e2uDkNq2E9okU1oWbTo)](#pinout-imageshttpfromwizcomshares2njicl1p6qom2n7fof15bja90kka5e2udknq2e9oku1owbto)
- [vyatta/vyos/EdgeOS](#vyattavyosedgeos)
	- [Firmware](#firmware)
- [Raspberry PI](#raspberry-pi)
	- [Console](#console)
- [/proc/cpuinfo](#proccpuinfo)
	- [ER-X](#er-x)
	- [Unifi-AC-Lite](#unifi-ac-lite)

<!-- /TOC -->

# [Pinout Images](http://fromwiz.com/share/s/2NJIcl1P6QOm2N7FoF15BJa90KkA5e2uDkNq2E9okU1oWbTo)

# vyatta/vyos/EdgeOS
## Firmware
```
show version 
add system image http://dl.ubnt.com/...
add system image egdeos-120821.tar
show system image 
reboot
show system image storage 
set system image default-boot 
delete system image 
```

# Unifi AP
BZ.v3.7.5# info
BZ.v3.7.5# set-inform http://unifi-controller:8080/inform

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
# /proc/cpuinfo
## ER-X
```
system type             : MT7621

processor               : 3
cpu model               : MIPS 1004Kc V2.15
BogoMIPS                : 583.68
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 32
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 4, address/irw mask: [0x0ffc, 0x0ffc, 0x0f                                                    fb, 0x0ffb]
isa                     : mips1 mips2 mips32r1 mips32r2
ASEs implemented        : mips16 dsp mt

ubnt@ubnt:~$ free -m
             total       used       free     shared    buffers     cached
Mem:           249        226         22          0         24         94
-/+ buffers/cache:        107        141
Swap:            0          0          0
```

## Unifi-AC-Lite
```
system type             : Qualcomm Atheros QCA956X rev 0

processor               : 0
cpu model               : MIPS 74Kc V5.0
BogoMIPS                : 385.84
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 32
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 4, address/irw mask: [0x0000, 0x01e8, 0x0058, 0x0048]
ASEs implemented        : mips16 dsp

BZ.v3.7.5# free -m
             total         used         free       shared      buffers
Mem:        126316        62272        64044            0            0
-/+ buffers:              62272        64044
Swap:            0            0            0
```

