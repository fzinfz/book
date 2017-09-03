<!-- TOC -->

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

<!-- /TOC -->
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
https://mikrotik.com/img/netaddresses2.pdf

