<!-- TOC -->

- [Switching Database Manager (SDM)](#switching-database-manager-sdm)
- [protocol data unit (PDU)](#protocol-data-unit-pdu)
- [MTU](#mtu)
- [Ethernet Performance](#ethernet-performance)
- [Bit Rate](#bit-rate)
- [design](#design)
- [arm/mipsel/x86 packages](#armmipselx86-packages)
- [Mikrotik](#mikrotik)
    - [Diagram](#diagram)
    - [CLI](#cli)
    - [PCQ](#pcq)
    - [PPP BCP](#ppp-bcp)
- [ER-X](#er-x)
    - [enable apt](#enable-apt)
    - [List dhcp/static clients](#list-dhcpstatic-clients)
    - [RIP](#rip)
    - [Firmware](#firmware)
    - [custom scripts](#custom-scripts)
- [Unifi-AC-Lite/LR](#unifi-ac-litelr)
    - [Commands](#commands)
    - [Issues](#issues)

<!-- /TOC -->

# Switching Database Manager (SDM) 
https://www.cisco.com/c/en/us/support/docs/switches/catalyst-3750-series-switches/44921-swdatabase-3750ss-44921.html

Ternary Content Addressable Memory (TCAM): rapid table lookups by ACL engine

    Layer 2 Learning    port learning policies
    Layer 2 Forwarding  learned unicast and multicast addresses
    Layer 3 Routing     unicast and multicast route lookups
    ACL / QoS Table     identify the traffic according to security and QoS ACLs

If these resources are exhausted:  
Layer 2 Forwarding and Learning, a new learned address will be flooded to all ports within the ingress VLAN.  
Layer 3 Routing, any L3 unicast and multicast routes will be learned only in software and not programmed into the TCAM. 

# protocol data unit (PDU)
    The layer 1 (Physical layer) PDU is the bit or, more generally, symbol ("stream").
    The layer 2 (Data link layer) PDU is the frame.
    The layer 3 (Network layer) PDU is the packet.
    The layer 4 (Transport layer) PDU is the segment for TCP or the datagram for UDP.

# MTU
https://en.wikipedia.org/wiki/Maximum_transmission_unit  
Ethernet, the maximum frame size is 1518 bytes, 18 bytes of which are overhead (header and FCS), resulting in an MTU of 1500 byte.

|Media for IP transport|Maximum transmission unit (bytes)|Notes|
|---|---|---|
|Internet IPv4 path MTU|At least 68,[5] max of 64KB[6]|Practical path MTUs are generally higher. Systems may use Path MTU Discovery[7] to find the actual path MTU.|
|Internet IPv6 path MTU|At least 1280,[8] max of 64KB, but up to 4GB with optional jumbogram[9]|Practical path MTUs are generally higher. Systems must use Path MTU Discovery[10] to find the actual path MTU.|
|Ethernet v2|1500[11]|Nearly all IP over Ethernet implementations use the Ethernet V2 frame format.|
|Ethernet jumbo frames|1501 – 9198 or more[14]|The limit varies by vendor. For correct interoperation, the whole Ethernet network must have the same MTU.[15] Jumbo frames are usually only seen in special-purpose networks.|
|PPPoE over Ethernet v2|1492[16]|= Ethernet v2 MTU (1500) - PPPoE header (8)|
|PPPoE over Ethernet jumbo frames|1493 – 9190 or more[17]|= Ethernet Jumbo Frame MTU (1501 - 9198) - PPPoE header (8)|
|WLAN (802.11)|2304|The maximum MSDU size is 2304 before encryption. WEP will add 8 bytes, WPA-TKIP 20 bytes, and WPA2-CCMP 16 bytes.|

# Ethernet Performance
https://kb.juniper.net/InfoCenter/index?page=content&id=kb14737

802.1Q，802.1ad (Q-in-Q)，MPLS  
![](https://kb.juniper.net/library/CUSTOMERSERVICE/14737/min_frame.JPG)  
![](https://kb.juniper.net/library/CUSTOMERSERVICE/GLOBAL_JTAC/14737/Figure3.JPG)  
![](https://kb.juniper.net/library/CUSTOMERSERVICE/GLOBAL_JTAC/doctorpeck/KB%20correction%20image.gif)

a packet will occupy at least 12+8+64=84 / 92 / 96 bytes on the wire  
1Gbps max PPS: 1,488,095 / 1,358,696 / 1,302,083

# Bit Rate
https://en.wikipedia.org/wiki/Bit_rate

`Net bit rate` ≤ `Gross bit rate` (`line rate`)  
IEEE 802.11a wireless network is the net bit rate of between 6 and 54 Mbit/s, while the gross bit rate is between 12 and 72 Mbit/s inclusive of error-correcting codes.  
Ethernet 100Base-TX physical layer standard is 100 Mbit/s, while the gross bitrate is 125 Mbit/second.

https://en.wikipedia.org/wiki/List_of_device_bit_rates

|Standard|Rate||Year|
|---|---|---|
|IEEE 802.11a|54 Mbit/s|6.75 MB/s|1999|
|IEEE 802.11b|11 Mbit/s|1.375 MB/s|1999|
|IEEE 802.11g|54 Mbit/s|6.75 MB/s|2003|
|IEEE 802.16 (WiMAX)|70 Mbit/s|8.75 MB/s|2004|
|IEEE 802.11n|600 Mbit/s|75 MB/s|2009|
|IEEE 802.11ac (maximum theoretical speed)|6.8–6.93 Gbit/s|850–866.25 MB/s|2012|
|IEEE 802.11ad (maximum theoretical speed)|7.14–7.2 Gbit/s|892.5–900 MB/s|2011|

# design
https://www.cisco.com/c/en/us/products/collateral/switches/nexus-5000-series-switches/white_paper_c11-522337.html  
horizontal distribution area (HDA)  
access layer, or equipment distribution area (EDA)

# arm/mipsel/x86 packages
http://pkg.entware.net/binaries/

    tar zxvf *.ipk
    tar zxvf data.tar.gz

# Mikrotik
## Diagram
![](http://mikrotik-trainings.com/docs/MikroTik_PacketFlow_Routing.jpg)

## CLI
    put [resolve google.com server 8.8.8.8]

## PCQ
https://wiki.mikrotik.com/wiki/Manual:Queue_Size  
http://mum.mikrotik.com/presentations/US08/janism.pdf  
https://wiki.mikrotik.com/wiki/Manual:HTB-Token_Bucket_Algorithm

## PPP BCP
https://wiki.mikrotik.com/wiki/Manual:BCP_bridging_(PPP_tunnel_bridging)

# ER-X
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

## enable apt
https://help.ubnt.com/hc/en-us/articles/205202560-EdgeRouter-Add-other-Debian-packages-to-EdgeOS

    configure
    set system package repository wheezy components 'main contrib non-free'
    set system package repository wheezy distribution wheezy 
    set system package repository wheezy url http://http.us.debian.org/debian
    commit
    save
    exit
    sudo apt-get update
    apt-cache search supervisor

## List dhcp/static clients
https://community.ubnt.com/t5/EdgeMAX/Anyway-to-see-connected-clients-Both-DHCP-and-Static/td-p/697223  

    set service dhcp-server hostfile-update enable  
    cat /etc/hosts

## RIP
    ubnt@ubnt# show protocols rip

        interface switch0
        interface eth0
        neighbor 192.168.3.1
        redistribute {
            connected {
            }
        }

## Firmware
    show version 
    add system image http://dl.ubnt.com/...
    add system image egdeos-120821.tar
    show system image 
    reboot
    show system image storage 
    set system image default-boot 
    delete system image 

    set interfaces ethernet eth1 address 192.168.3.2/24
    commit

## custom scripts    
    chmod +x /config/scripts/post-config.d/yourscript.sh
        #!/bin/bash

# Unifi-AC-Lite/LR
```
system type             : Qualcomm Atheros QCA956X rev 0
processor               : 0
cpu model               : MIPS 74Kc V5.0
BogoMIPS                : 385.84
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 32
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 4, ...
ASEs implemented        : mips16 dsp

BZ.v3.7.5# free -m
             total         used         free       shared      buffers
Mem:(Lite)        126316        62272        64044            0            0
-/+ buffers:              62272        64044
Mem:(LR)        126272        66764        59508            0            0
-/+ buffers:              66764        59508
Swap:            0            0            0
```

## Commands
    BZ.v3.7.5# info
    BZ.v3.7.5# set-inform http://unifi:8080/inform

## Issues
Every minor setting change on controller causes SSID reset.