<!-- TOC -->

- [Open Source Software for Routing](#open-source-software-for-routing)
- [BGP](#bgp)
    - [Private AS](#private-as)
- [Virtual networking modes](#virtual-networking-modes)
- [Tools for Windows](#tools-for-windows)
- [Tools for All platforms](#tools-for-all-platforms)
- [Router OSes](#router-oses)
- [MPLS](#mpls)
    - [Mikrotik](#mikrotik)
- [VPLS](#vpls)
    - [Mikrotik](#mikrotik-1)
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
- [Multi WAN](#multi-wan)
- [Load Balancing](#load-balancing)
- [Transparent Proxy](#transparent-proxy)
    - [V2Ray - Go](#v2ray---go)
    - [redsocks - C](#redsocks---c)
    - [Tinyproxy - C](#tinyproxy---c)
    - [moproxy - Rust](#moproxy---rust)
    - [Any Proxy - Go](#any-proxy---go)
    - [avege - Go port of redsocks](#avege---go-port-of-redsocks)
    - [ipfw](#ipfw)
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
https://github.com/fatedier/frp
https://github.com/lovedboy/gortcp

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
TPROXY required for UDP, Linux support only

    "inboundDetour": [ {
        "protocol": "dokodemo-door",
        "port": 20088,
        "settings": {
            "network": "tcp,udp",
            "timeout": 10,
            "followRedirect": true
        }
    } ],

    iptables -t nat -N V2RAY
    iptables -t nat -I V2RAY -p tcp --dport 4433 -j RETURN  # bypass Port

    # See Wikipedia and RFC5735 for full list of reserved networks.
    iptables -t nat -A V2RAY -d 0.0.0.0/8 -j RETURN
    iptables -t nat -A V2RAY -d 10.0.0.0/8 -j RETURN
    iptables -t nat -A V2RAY -d 127.0.0.0/8 -j RETURN
    iptables -t nat -A V2RAY -d 169.254.0.0/16 -j RETURN
    iptables -t nat -A V2RAY -d 172.16.0.0/12 -j RETURN
    iptables -t nat -A V2RAY -d 192.168.0.0/16 -j RETURN
    iptables -t nat -A V2RAY -d 224.0.0.0/4 -j RETURN
    iptables -t nat -A V2RAY -d 240.0.0.0/4 -j RETURN

    # Anything else should be redirected to Dokodemo-door's local port
    iptables -t nat -A V2RAY -p tcp -j REDIRECT --to-ports 20088
    iptables -t nat -I OUTPUT -p tcp -j V2RAY
    iptables -t nat -I PREROUTING -p tcp -j V2RAY

    # Add any UDP rules
    iptables -t mangle -N V2RAY
    iptables -t mangle -N V2RAY_MARK

    ip route add local default dev lo table 100
    ip rule add fwmark 1 lookup 100
    iptables -t mangle -A V2RAY -p udp --dport 53 -j TPROXY --on-port 20088 --tproxy-mark 0x01/0x01
    iptables -t mangle -A V2RAY_MARK -p udp --dport 53 -j MARK --set-mark 1

    iptables -t mangle -A PREROUTING -j V2RAY
    iptables -t mangle -A OUTPUT -j V2RAY_MARK

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

## ipfw
    sudo ipfw add fwd 127.0.0.1,12345 tcp from not me to any 80 in via en1
    sudo ipfw add fwd 127.0.0.1,12345 tcp from not me to any 443 in via en1

# NetFlow Software
https://www.cisco.com/c/en/us/products/ios-nx-os-software/ios-netflow/networking_solutions_products_genericcontent0900aecd805ff72b.html

# IPV6
https://tunnelbroker.net/