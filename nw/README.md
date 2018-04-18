<!-- TOC -->

- [Open Source Software for Routing](#open-source-software-for-routing)
- [BGP](#bgp)
    - [Private AS](#private-as)
- [Virtual networking modes](#virtual-networking-modes)
- [Tools for Windows](#tools-for-windows)
- [Tools for All platforms](#tools-for-all-platforms)
- [Router OSes](#router-oses)
- [OSPF](#ospf)
    - [Mikrotik](#mikrotik)
- [MPLS](#mpls)
    - [Mikrotik](#mikrotik-1)
- [VPLS](#vpls)
    - [Mikrotik](#mikrotik-2)
    - [OpenBSD](#openbsd)
    - [Linux](#linux)
- [L7 filters](#l7-filters)
- [Subnet Helper](#subnet-helper)
- [MAC addresss <-> Vender](#mac-addresss---vender)
- [DHCP Options](#dhcp-options)
- [Tuning](#tuning)
- [TCP congestion control](#tcp-congestion-control)
    - [BBR](#bbr)
- [Introspectable tunnels to localhost](#introspectable-tunnels-to-localhost)
    - [frp](#frp)
- [Multi WAN](#multi-wan)
- [Load Balancing](#load-balancing)
- [Transparent Proxy](#transparent-proxy)
    - [V2Ray - Go](#v2ray---go)
    - [redsocks - C](#redsocks---c)
    - [Tinyproxy - C](#tinyproxy---c)
    - [moproxy - Rust](#moproxy---rust)
    - [Any Proxy - Go](#any-proxy---go)
    - [avege - Go port of redsocks](#avege---go-port-of-redsocks)
- [NetFlow Software](#netflow-software)
- [IPV6](#ipv6)

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

# OSPF
## Mikrotik
    /routing ospf instance
    set [ find default=yes ] redistribute-connected=as-type-1
    /routing ospf network
    add area=backbone network=192.168.1.0/24

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
https://github.com/lovedboy/gortcp

## frp
https://github.com/fatedier/frp

    docker run --rm -it --entrypoint=/bin/sh hyperapp/frp
    docker run --name frp  -d --restart unless-stopped --net host hyperapp/frp

    / # cat frps.ini
    [common]
    bind_port = 7000
    privilege_token = xxx

    / # cat frpc.ini
    [common]
    server_addr = 127.0.0.1
    server_port = 7000
    privilege_token = xxx

    [ssh]
    type = tcp
    local_ip = 127.0.0.1
    local_port = 22
    remote_port = 6000


# Multi WAN
pfSense: https://www.cyberciti.biz/faq/howto-configure-dual-wan-load-balance-failover-pfsense-router/  
VYOS: https://wiki.vyos.net/wiki/WAN_load_balancing  
OpenBSD: https://www.openbsd.org/faq/pf/pools.html#outgoing  
OpenWRT: https://wiki.openwrt.org/doc/howto/mwan3  
ROS: https://mum.mikrotik.com/presentations/US12/tomas.pdf  

# Load Balancing
https://wiki.koumbit.net/LoadBalancingService/SoftwareComparison

    Reverse proxying (AKA Layer-7 switching)
        Varnish Cache
        Nginx
        Squid
        Apache mod_proxy
        Relayd
    TCP connection redirection (AKA Layer-4 switching)
        IPVS, part of the LVS suite
        Ha-proxy
        Relayd

# Transparent Proxy
## V2Ray - Go
https://www.v2ray.com/chapter_02/protocols/dokodemo.html  

    "inboundDetour": [ {
        "protocol": "dokodemo-door",
        "port": 20088,
        "settings": {
            "network": "tcp,udp",   // TPROXY required for UDP
            "timeout": 10,
            "followRedirect": true  // Linux support only
        }
    } ],

## redsocks - C
https://github.com/darkk/redsocks  
Linux/iptables, OpenBSD/pf and FreeBSD/ipfw are supported.

Use on Mac: http://lucumr.pocoo.org/2013/1/6/osx-wifi-proxy/

## Tinyproxy - C
https://github.com/tinyproxy/tinyproxy

## moproxy - Rust
https://github.com/sorz/moproxy  

## Any Proxy - Go
https://github.com/ryanchapman/go-any-proxy  
TCP CONNECTION

    ./any_proxy -l :7777 -p "proxy_ip:1080"

## avege - Go port of redsocks
https://github.com/avege/avege  

# NetFlow Software
https://www.cisco.com/c/en/us/products/ios-nx-os-software/ios-netflow/networking_solutions_products_genericcontent0900aecd805ff72b.html

# IPV6
https://tunnelbroker.net/