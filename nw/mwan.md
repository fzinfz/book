<!-- TOC -->

- [OS](#os)
- [OpenMPTCProuter](#openmptcprouter)
- [VyOS](#vyos)
- [ClearOS](#clearos)
- [Linux Bond](#linux-bond)
- [Multipath TCP MPTCP](#multipath-tcp-mptcp)
    - [kernel >= v5.6](#kernel--v56)
    - [kernel <= 5.4](#kernel--54)
- [L4](#l4)

<!-- /TOC -->

# OS
- [OpenWRT mwan3](/OpenWrt/mwan3.md)
- [Mikrotik](./mikrotik.md)
- OpenBSD: https://www.openbsd.org/faq/pf/pools.html#outgoing  
- pfSense: https://www.cyberciti.biz/faq/howto-configure-dual-wan-load-balance-failover-pfsense-router/

# OpenMPTCProuter
- OpenWRT+MPTCP+Shadowsocks+Glorytun(multipath UDP tunnel): https://www.openmptcprouter.com/screenshot
- default login: root / <no_pass> ; then config: 

# VyOS
- https://wiki.vyos.net/wiki/WAN_load_balancing
- https://docs.vyos.io/en/equuleus/configuration/loadbalancing/index.html | incompatible with dynamic routing protocol

# ClearOS
- network config: https://documentation.clearos.com/content:en_us:7_ug_network
- mwan: https://www.clearos.com/marketplace/network/Multi-WAN
- skip wizard: https://w.x.y.z:81/app/base/wizard/stop

# Linux Bond
https://www.kernel.org/doc/Documentation/networking/bonding.txt

    cat /proc/net/bonding/*

https://wiki.mikrotik.com/wiki/Manual:Interface/Bonding#Bonding_modes

Bonding vs Load Balancing: https://di-marco.net/blog/it/2022-01-29-multi_wan_and_internet_bonding_with_openmptcprouter/

# Multipath TCP (MPTCP)
Year 2013 | PPT | 185 pages: http://multipath-tcp.org/data/MultipathTCP-netsys.pdf

## kernel >= v5.6
https://www.mptcp.dev/
https://github.com/multipath-tcp/mptcp_net-next/wiki

## kernel <= 5.4
https://www.multipath-tcp.org/

# L4
- OpenWRT： /cgi-bin/luci/admin/services/[passwall](https://github.com/xiaorouji/openwrt-passwall/issues/2463)/haproxy

