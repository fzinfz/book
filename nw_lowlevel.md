<!-- TOC -->

- [OSI Physical layer](#osi-physical-layer)
    - [Network Equipments](#network-equipments)
- [Switching Database Manager (SDM)](#switching-database-manager-sdm)
- [protocol data unit (PDU)](#protocol-data-unit-pdu)
- [MTU](#mtu)
- [MAC](#mac)
    - [unicast](#unicast)
    - [multicast addressing](#multicast-addressing)
    - [Applications](#applications)
- [Extended Unique Identifier (EUI) -64 identifiers](#extended-unique-identifier-eui--64-identifiers)
- [IEEE 802](#ieee-802)
- [Ethernet II (DIX Ethernet) & IEEE 802.3 Frame](#ethernet-ii-dix-ethernet--ieee-8023-frame)
- [802.1Q](#8021q)
- [Bit Rate](#bit-rate)
- [Design](#design)
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

# OSI Physical layer
https://en.wikipedia.org/wiki/Physical_layer  

    Bluetooth physical layer
    Ethernet physical layer Including 10/100/1000BASE-T, 10BASE2, 10BASE5, 100BASE-TX, 100BASE-FX, 1000BASE-SX
    I²C, I²S
    IEEE 1394 interface
    ISDN
    Optical Transport Network (OTN)
    USB physical layer
    Varieties of 802.11 Wi-Fi physical layers

## Network Equipments
    Network interface controller
    Repeater
    Ethernet hub
    Modem
    Fiber media converter

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

# MAC
https://en.wikipedia.org/wiki/MAC_address  
![](https://upload.wikimedia.org/wikipedia/commons/thumb/9/94/MAC-48_Address.svg/950px-MAC-48_Address.svg.png)

12-34-56-78-9A-BC =》 000100{1}【0】 00110100 01010110 01111000 10011010 10111100  
【0】 in individual addresses and set to 【1】 in group addresses

## unicast
the frame is meant to reach only one receiving NIC.
transmitted to all nodes within the collision domain.
    In a modern wired setting the collision domain usually is the length of the Ethernet cable between two network cards. 
    In a wireless setting, the collision domain is as far as the radio transmitter can reach. 
A switch will forward a unicast frame through all of its ports (except for the port that originated the frame), an action known as `unicast flood`, if the switch has no knowledge of which port leads to that MAC address. 

## multicast addressing
the frame will still be sent only once; however, NICs will choose to accept it based on criteria other than the matching of a MAC address: for example, based on a configurable list of accepted multicast MAC addresses.  
Group addresses, like individual addresses, can be universally administered or locally administered.

FF:FF:FF:FF:FF:FF. A `broadcast` frame is flooded and is forwarded to and accepted by all other nodes.

## Applications
    Ethernet
    802.11 wireless networks
    Bluetooth
    IEEE 802.5 token ring
    most other IEEE 802 networks
    Fiber Distributed Data Interface (FDDI)
    Asynchronous Transfer Mode (ATM), switched virtual connections only, as part of an NSAP address
    Fibre Channel and Serial Attached SCSI (as part of a World Wide Name)
    The ITU-T G.hn standard

# Extended Unique Identifier (EUI) -64 identifiers
    IEEE 1394 (FireWire)
    IPv6 (Modified EUI-64 as the least-significant 64 bits of a unicast network address or link-local address when stateless autoconfiguration is used)
    ZigBee / 802.15.4 / 6LoWPAN wireless personal-area networks

# IEEE 802
http://www.ieee802.org/
    802.1 Higher Layer LAN Protocols Working Group
    802.2 developed the Logical Link Control (LLC) standard. officially disbanded.
    802.3 Ethernet Working Group
    802.11 Wireless LAN Working Group
    802.15 Wireless Personal Area Network (WPAN) Working Group
    802.16 Broadband Wireless Access Working Group
    802.18 Radio Regulatory TAG
    802.19 Wireless Coexistence Working Group
    802.21 Media Independent Handover Services Working Group
    802.22 Wireless Regional Area Networks
    802.24 Vertical Applications TAG

# Ethernet II (DIX Ethernet) & IEEE 802.3 Frame
https://en.wikipedia.org/wiki/Ethernet_frame  
A version 1 Ethernet frame was never commercially deployed.

|||
|---|---|
|Preamble|7 octets|
|Start of frame delimiter|1 octet|
|MAC destination|6 octets|
|MAC source|6 octets|
|802.1Qtag (optional)|(4 octets)|
|Ethertype(Ethernet II) or length (IEEE 802.3)|2 octets|
|Payload|46‑1500 octets|
|Frame check sequence(32‑bit CRC)|4 octets|
|Interpacket gap|12 octets|

The header = dst/src MAC + EtherType + optional IEEE 802.1Q tag

EtherType can be used for two different purposes:
- `<=1500`: the maximum length of the payload field of an Ethernet 802.3 frame is 1500 octets (0x05DC).
- `>=1536`: protocol encapsulated in the payload of the frame. used as [EtherType](https://www.iana.org/assignments/ieee-802-numbers/ieee-802-numbers.xhtml), the length of the frame is determined by the location of the interpacket gap and valid frame check sequence (FCS).

![](https://upload.wikimedia.org/wikipedia/commons/7/72/Ethernet_Frame.png)

https://kb.juniper.net/InfoCenter/index?page=content&id=kb14737

802.1Q，802.1ad (Q-in-Q)，MPLS  
![](https://kb.juniper.net/library/CUSTOMERSERVICE/14737/min_frame.JPG)  
![](https://kb.juniper.net/library/CUSTOMERSERVICE/GLOBAL_JTAC/14737/Figure3.JPG)  
![](https://kb.juniper.net/library/CUSTOMERSERVICE/GLOBAL_JTAC/doctorpeck/KB%20correction%20image.gif)

a packet will occupy at least 12+8+64=84 / 92 / 96 bytes on the wire  
1Gbps max PPS: 1,488,095 / 1,358,696 / 1,302,083

# 802.1Q
![](https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/TCPIP_802.1ad_DoubleTag.svg/2656px-TCPIP_802.1ad_DoubleTag.svg.png)


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

# Design
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