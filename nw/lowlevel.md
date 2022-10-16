<!-- TOC -->

- [OSI Physical layer](#osi-physical-layer)
- [RFC](#rfc)
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
- [Ethernet II (DIX Ethernet) & 802.3 Frame](#ethernet-ii-dix-ethernet--8023-frame)
  - [EtherType](#ethertype)
  - [MPLS](#mpls)
- [802.1Q & 802.1ad (Q-in-Q)](#8021q--8021ad-q-in-q)
  - [Cisco](#cisco)
- [IEEE P802.1p](#ieee-p8021p)
- [Bit Rate](#bit-rate)
  - [Wireless](#wireless)
- [FC](#fc)
  - [Layers](#layers)
- [Wireshark](#wireshark)
- [Design](#design)

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

# RFC
MAC bridge: http://profesores.elo.utfsm.cl/~agv/elo309/doc/802.1D-1998.pdf

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
https://en.wikipedia.org/wiki/Protocol_data_unit

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

12-34-56-78-9A-BC =》 000100{1}[0] 00110100 01010110 01111000 10011010 10111100  
[0] individual addresses  
[1] group addresses

## unicast
the frame is meant to reach only one receiving NIC.
transmitted to all nodes within the collision domain.
- In a modern wired setting the collision domain usually is the length of the Ethernet cable between two network cards.
- In a wireless setting, the collision domain is as far as the radio transmitter can reach.

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

# Ethernet II (DIX Ethernet) & 802.3 Frame
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

Layer 2 Ethernet frame:         ← 64–1522 octets →
Layer 1 Ethernet packet & IPG:	← 72–1530 octets →	← 12 octets →

The header = dst/src MAC + EtherType + optional IEEE 802.1Q tag

|Frame type|Ethertype or length|Payload start two bytes|
|---|---|---|
|Ethernet II|≥ 1536|Any|
|Novell raw IEEE 802.3|≤ 1500|0xFFFF|
|IEEE 802.2 LLC|≤ 1500|Other|
|IEEE 802.2 SNAP|≤ 1500|0xAAAA|

EtherType can be used for two different purposes:
- `<=1500`: the maximum length of the payload field of an Ethernet 802.3 frame is 1500 octets (0x05DC).
- `>=1536`: protocol encapsulated in the payload of the frame. used as [EtherType](https://www.iana.org/assignments/ieee-802-numbers/ieee-802-numbers.xhtml), the length of the frame is determined by the location of the interpacket gap and valid frame check sequence (FCS).

most popular FCS algorithm is a cyclic redundancy check (CRC)

![](https://upload.wikimedia.org/wikipedia/commons/7/72/Ethernet_Frame.png)

https://kb.juniper.net/InfoCenter/index?page=content&id=kb14737

a packet will occupy at least 12+8+64=84 / 92 / 96 bytes on the wire  
1Gbps max PPS: 1,488,095 / 1,358,696 / 1,302,083

## EtherType
    0x0800  Internet Protocol Version 4 (IPv4)
    0x86DD  Internet Protocol Version 6 (IPv6)

    0x0806  Address Resolution Protocol (ARP)
    0x0808  Frame Relay ARP
    0x8035  Reverse Address Resolution Protocol (RARP)

    0x8847  MPLS
    0x8848  MPLS with upstream-assigned label

    0x880B  Point-to-Point Protocol (PPP)
    0x8863  PPP over Ethernet (PPPoE) Discovery Stage
    0x8864  PPP over Ethernet (PPPoE) Session Stage

    0x8100  IEEE Std 802.1Q   - Customer VLAN Tag Type (C-Tag, formerly
                                called the Q-Tag) (initially Wellfleet)
    0x88A8  IEEE Std 802.1Q   - Service VLAN tag identifier (S-Tag)

    0x8808  IEEE Std 802.3    - Ethernet Passive Optical Network (EPON)
    0x888E  IEEE Std 802.1X   - Port-based network access control

    0x88B5  IEEE Std 802      - Local Experimental Ethertype
    0x88B6  IEEE Std 802      - Local Experimental Ethertype
    0x88B7  IEEE Std 802      - OUI Extended Ethertype

    0x88C7  IEEE Std 802.11   - Pre-Authentication (802.11i)
    0x890D  IEEE Std 802.11   - Fast Roaming Remote Request (802.11r)

    0x88CC  IEEE Std 802.1AB  - Link Layer Discovery Protocol (LLDP)
    0x88E5  IEEE Std 802.1AE  - Media Access Control Security
    0x8917  IEEE Std 802.21   - Media Independent Handover Protocol
    0x88F5  IEEE Std 802.1Q   - Multiple VLAN Registration Protocol(MVRP)
    0x88F6  IEEE Std 802.1Q   - Multiple Multicast Registration Protocol (MMRP)
    0x8929  IEEE Std 802.1Qbe - Multiple I-SID Registration Protocol
    0x8940  IEEE Std 802.1Qbg - ECP Protocol (also used in 802.1BR)

## MPLS
![](https://kb.juniper.net/library/CUSTOMERSERVICE/GLOBAL_JTAC/doctorpeck/KB%20correction%20image.gif)

# 802.1Q & 802.1ad (Q-in-Q)
![](https://kb.juniper.net/library/CUSTOMERSERVICE/GLOBAL_JTAC/14737/Figure3.JPG)  

![](https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/TCPIP_802.1ad_DoubleTag.svg/2656px-TCPIP_802.1ad_DoubleTag.svg.png)

<table width="400px">
   <caption>802.1Q tag format</caption>
   <tbody>
      <tr>
         <th width="50%">16 bits</th>
         <th width="9.375%">3 bits</th>
         <th width="3.125%">1 bit</th>
         <th width="37.5%">12 bits</th>
      </tr>
      <tr>
         <td rowspan="2" align="center">TPID</td>
         <td colspan="3" align="center">TCI</td>
      </tr>
      <tr>
         <td align="center">PCP</td>
         <td align="center">DEI</td>
         <td align="center">VID</td>
      </tr>
   </tbody>
</table>

Tag protocol identifier (TPID)： 0x8100/0x88A8  
Tag control information (TCI)
- Priority code point (PCP)： IEEE 802.1p class of service
- Drop eligible indicator (DEI)/Canonical Format Indicator (CFI)： IEEE 802.1Q-2011 clause 6.9.3
- VLAN identifier (VID)： up to 4,094 VLANs；0x000 no VLAN; 0x001 default; 0xFFF reserved.

Multiple VLAN Registration Protocol (MVRP), an application of the Multiple Registration Protocol, allowing bridges to negotiate the set of VLANs to be used over a specific link.

## Cisco
[VLAN Trunking Protocol (VTP)](https://en.wikipedia.org/wiki/VLAN_Trunking_Protocol) is a Cisco proprietary protocol that propagates the definition of Virtual Local Area Networks (VLAN) on the whole local area network.

[Cisco Inter-Switch Link (ISL)](https://en.wikipedia.org/wiki/Cisco_Inter-Switch_Link) is a Cisco Systems proprietary protocol that maintains VLAN information in Ethernet frames as traffic flows between switches and routers, or switches and switches. an alternative to the IEEE 802.1Q standard.

[Dynamic Trunking Protocol (DTP)](https://en.wikipedia.org/wiki/Dynamic_Trunking_Protocol) is a proprietary networking protocol developed by Cisco Systems for the purpose of negotiating trunking on a link between two VLAN-aware switches, and for negotiating the type of trunking encapsulation to be used.

# IEEE P802.1p
|PCP value|Priority|Acronym|Traffic types|
|---|---|---|---|
|1|0 (lowest)|BK|Background|
|0|1 (default)|BE|Best effort|
|2|2|EE|Excellent effort|
|3|3|CA|Critical applications|
|4|4|VI|Video, < 100 ms latency and jitter|
|5|5|VO|Voice, < 10 ms latency and jitter|
|6|6|IC|Internetwork control|
|7|7 (highest)|NC|Network control|

# Bit Rate
https://en.wikipedia.org/wiki/Bit_rate

`Net bit rate` ≤ `Gross bit rate` (`line rate`)  
IEEE 802.11a wireless network is the net bit rate of between 6 and 54 Mbit/s, while the gross bit rate is between 12 and 72 Mbit/s inclusive of error-correcting codes.  
Ethernet 100Base-TX physical layer standard is 100 Mbit/s, while the gross bitrate is 125 Mbit/second.

## Wireless
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

# FC
https://en.wikipedia.org/wiki/Fibre_Channel

|NAME|Line-rate (gigabaud)|Line coding|Nominal throughput/direction|Net throughput/direction| Availability|
|---|---|---|---|
|8GFC|8.5|8b10b|800|825.8|2005|
|10GFC|10.51875|64b66b|1,200|1,239|2008|
|16GFC|14.025|64b66b|1,600|1,652|2011|
|32GFC "Gen 6"|28.05|64b66b|3,200|3,303|2016[6]|
|128GFC "Gen 6"|28.05 ×4|64b66b|12,800|13,210|2016[6]|

## Layers
    FC-4 – Protocol-mapping layer, in which upper level protocols such as SCSI, IP or FICON, are encapsulated into Information Units (IUs) for delivery to FC-2. Current FC-4s include FCP-4, FC-SB-5, and FC-NVMe.
    FC-3 – Common services layer, a thin layer that could eventually implement functions like encryption or RAID redundancy algorithms; multiport connections;
    FC-2 – Signaling Protocol, defined by the Fibre Channel Framing and Signaling 4 (FC-FS-4) standard, consists of the low level Fibre Channel protocols; port to port connections;
    FC-1 – Transmission Protocol, which implements line coding of signals;
    FC-0 – PHY, includes cabling, connectors etc.;

# Wireshark
https://wiki.wireshark.org/Ethernet#Frame_Check_Sequence_.28FCS.29_field

    !(eth.addr==08.00.08.15.ca.fe)
    (eth.dst[0] & 1) && eth.dst!=ff:ff:ff:ff:ff:ff  # Multicast - Broadcast

# Design
https://www.cisco.com/c/en/us/products/collateral/switches/nexus-5000-series-switches/white_paper_c11-522337.html  
horizontal distribution area (HDA)  
access layer, or equipment distribution area (EDA)