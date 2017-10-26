<!-- TOC -->

- [Open Source Software for Routing](#open-source-software-for-routing)
- [BGP](#bgp)
    - [Private AS](#private-as)
- [Virtual networking modes](#virtual-networking-modes)
- [SDN](#sdn)
    - [Switch](#switch)
    - [Controller](#controller)
        - [Python](#python)
        - [C++](#c)
        - [JAVA](#java)
- [Tools for Windows](#tools-for-windows)
- [Tools for All platforms](#tools-for-all-platforms)
- [Router OSes](#router-oses)
- [MPLS](#mpls)
    - [Mikrotik](#mikrotik)
- [VPLS](#vpls)
    - [Mikrotik](#mikrotik-1)
    - [OpenBSD](#openbsd)
    - [Linux](#linux)
- [Mikrotik](#mikrotik-2)
    - [PCQ](#pcq)
- [PPP BCP](#ppp-bcp)
- [VRF](#vrf)
- [L7 filters](#l7-filters)
- [Subnet Helper](#subnet-helper)
- [MAC addresss <-> Vender](#mac-addresss---vender)
- [DHCP Options](#dhcp-options)
- [Tuning](#tuning)
- [TCP congestion control](#tcp-congestion-control)
    - [BBR](#bbr)
- [Introspectable tunnels to localhost](#introspectable-tunnels-to-localhost)
- [IDS/IPS](#idsips)
    - [Snort(NIDS/NIDS)](#snortnidsnids)
    - [OSSEC(HIDS)](#ossechids)
    - [Suricata(NIDS/NIPS/MSM)](#suricatanidsnipsmsm)
    - [Compare](#compare)
- [How to hack](#how-to-hack)

<!-- /TOC -->

# Open Source Software for Routing 
https://conference.apnic.net/__data/assets/pdf_file/0020/50681/osr_apnic34_1346044930.pdf

# BGP 
https://github.com/Exa-Networks/exabgp
implement SDN by transforming BGP messages into friendly plain text or JSON

http://bird.network.cz/
http://www.openbgpd.org/ftp.html


https://github.com/openstack/networking-bagpipe
BGP-based VPNs as a backend for Neutron

## Private AS
https://tools.ietf.org/html/rfc6996#section-5
64512 - 65534
4200000000 - 4294967294

# Virtual networking modes
https://thenewstack.io/hackers-guide-kubernetes-networking/  
![](https://cdn.thenewstack.io/media/2017/02/7a021d86-virtual-networking-1024x380.png)

# SDN
## Switch
https://github.com/openvswitch/ovs
ovs-vswitchd
ovsdb-server
ovs-dpctl, a tool for configuring the switch kernel module.
ovs-vsctl, a utility for querying and updating the configuration of ovs-vswitchd.
ovs-appctl, a utility that sends commands to running Open vSwitch daemons.

ovs-ofctl, a utility for querying and controlling OpenFlow switches and controllers.
ovs-pki, a utility for creating and managing the public-key infrastructure for OpenFlow switches.
ovs-testcontroller, a simple OpenFlow controller that may be useful for testing (though not for production).
A patch to tcpdump that enables it to parse OpenFlow messages.

## Controller
### Python
http://ryu.readthedocs.io/en/latest/getting_started.html
https://hub.docker.com/r/osrg/ryu-book/

### C++
https://github.com/Juniper/contrail-controller  
https://github.com/Juniper/contrail-vrouter

### JAVA
https://hub.docker.com/r/opendaylight/odl/  
https://hub.docker.com/r/onosproject/onos/  
https://github.com/floodlight/floodlight

# Tools for Windows 
Microsoft Message Analyzer: https://www.microsoft.com/en-us/download/details.aspx?id=44226  
Microsoft Network Monitor(2010): https://www.microsoft.com/en-us/download/details.aspx?id=4865  
BTest: https://mikrotik.com/download/btest.exe  
Force socks: https://www.socksproxychecker.com/sockscap.html

# Tools for All platforms
Wireshark: https://www.wireshark.org/download.html

# Router OSes
https://wiki.vyos.net/wiki/User_Guide  
https://mikrotik.com/download  
https://www.clearos.com/clearfoundation/software/clearos-7-community      
https://docs.cumulusnetworks.com/display/ROH/Configuring+Cumulus+Quagga

# MPLS 
## Mikrotik 
https://wiki.mikrotik.com/wiki/Manual:MPLSVPLS  
Targeted LDP session is session that is established between two routers that are not direct neighbors.

https://tools.ietf.org/html/rfc3031     Multiprotocol Label Switching Architecture
https://tools.ietf.org/html/rfc5036 / Obsoletes: 3036   LDP Specification

# VPLS 
https://en.wikipedia.org/wiki/Pseudo-wire

## Mikrotik
https://tools.ietf.org/html/rfc4761     VPLS Using BGP for Auto-Discovery and Signaling
https://tools.ietf.org/html/rfc4762     VPLS Using LDP Signaling
https://tools.ietf.org/html/rfc4447     (cisco-style Signaling)
https://tools.ietf.org/html/rfc4623     PWE3 Fragmentation and Reassembly

## OpenBSD
https://github.com/rwestphal/openbsd-ldpd/wiki/VPLS-basic-test-setup
https://github.com/openbsd/src/blob/master/usr.sbin/ldpd/l2vpn.c
RFC4447:
- Section 6.2: control word negotiation
- Section 5.4.3: pseudowire status negotiation
- PWid group wildcard

## Linux
https://github.com/rwestphal/quagga-ldpd/wiki/ldpd-basic-test-setup

https://lwn.net/Articles/730526/ 
https://github.com/6WIND/iproute2/commits/master/ip/iplink_vpls.c
TODO：https://tools.ietf.org/html/rfc4385 PWE3 Control Word for Use over an MPLS PSN （diff with 4623?）

https://github.com/eqvinox/vpls-iproute2/commits/vpls

https://wiki.vyos.net/wiki/Proposed_enhancements 

# Mikrotik 
```
put [resolve google.com server 8.8.8.8]
```

## PCQ
https://wiki.mikrotik.com/wiki/Manual:Queue_Size  
http://mum.mikrotik.com/presentations/US08/janism.pdf  
https://wiki.mikrotik.com/wiki/Manual:HTB-Token_Bucket_Algorithm

# PPP BCP
https://wiki.mikrotik.com/wiki/Manual:BCP_bridging_(PPP_tunnel_bridging)

# VRF
https://docs.cumulusnetworks.com/display/DOCS/Virtual+Routing+and+Forwarding+-+VRF
multiple independent routing tables working simultaneously on the same router or switch
Think of this feature as VLAN for layer 3

# L7 filters
http://l7-filter.sourceforge.net/protocols

# Subnet Helper
http://www.balticnetworkstraining.com/subnet-calculator/  
http://www.mikrotik.com/img/netaddresses2.pdf
E.g.:
.96-127/27: #2^5
.0-127/25: #2^7

# MAC addresss <-> Vender
http://aruljohn.com/mac.pl

# DHCP Options
http://www.iana.org/assignments/bootp-dhcp-parameters/bootp-dhcp-parameters.xhtml

# Tuning
https://fasterdata.es.net/assets/Papers-and-Publications/100G-Tuning-TechEx2016.tierney.pdf

# TCP congestion control
https://en.wikipedia.org/wiki/TCP_congestion_control#Algorithms

## BBR
https://www.ietf.org/proceedings/97/slides/slides-97-iccrg-bbr-congestion-control-02.pdf   
http://www.thequilt.net/wp-content/uploads/BBR-TCP-Opportunities.pdf
http://queue.acm.org/detail.cfm?id=3022184
http://netdevconf.org/1.2/slides/oct5/04_Making_Linux_TCP_Fast_netdev_1.2_final.pdf

# Introspectable tunnels to localhost
https://github.com/inconshreveable/ngrok
https://github.com/fatedier/frp
https://github.com/lovedboy/gortcp

# IDS/IPS
Network Intrusion Detection System (NIDS) engine  
Network Intrusion Prevention System (NIPS) engine  
Network Security Monitoring (NSM) engine

## Snort(NIDS/NIDS)
https://doc.pfsense.org/index.php/Setup_Snort_Package

## OSSEC(HIDS)
https://en.wikipedia.org/wiki/OSSEC  
log analysis, integrity checking, Windows registry monitoring, rootkit detection, time-based alerting, and active response.

https://ossec.github.io/docs/manual/supported-systems.html

## Suricata(NIDS/NIPS/MSM)
Suricata is a network IDS, IPS and NSM engine.  
https://github.com/OISF/suricata  
https://suricata-ids.org/features/all-features/  
w/ pfSense: http://elatov.github.io/2016/11/setup-suricata-on-pfsense/  
w/ Mikrotik: https://forum.mikrotik.com/viewtopic.php?t=111727

## Compare
https://www.aldeid.com/wiki/Suricata-vs-snort

# How to hack
https://github.com/ethicalhack3r/DVWA
a PHP/MySQL web application that is damn vulnerable. 

https://www.youtube.com/playlist?list=PL0-xwzAwzllx4w5OYdRoVTqlNvQ7xALNM