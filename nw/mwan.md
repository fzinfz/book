- [OS](#os)
- [Linux Bond](#linux-bond)
- [Multipath TCP (MPTCP)](#multipath-tcp-mptcp)
  - [kernel \>= v5.6](#kernel--v56)
  - [kernel \<= 5.4](#kernel--54)

# OS
- [ClearOS](https://www.clearos.com/products/purchase/clearos-downloads) | need [Registration](https://secure.clearcenter.com/portal/index.jsp): https://documentation.clearos.com/content:en_us:7_ug_multiwan
- OpenWRT: mwan3
- [OpenMPTCProuter](https://www.openmptcprouter.com/): based on OpenWRT+MPTCP+Shadowsocks+Glorytun(multipath UDP tunnel)
- [Mikrotik](/nw/mikrotik/)

# Linux Bond
https://www.kernel.org/doc/Documentation/networking/bonding.txt

    cat /proc/net/bonding/*

https://wiki.mikrotik.com/wiki/Manual:Interface/Bonding#Bonding_modes

Bonding vs Load Balancing: https://di-marco.net/blog/it/2022-01-29-multi_wan_and_internet_bonding_with_openmptcprouter/

# Multipath TCP (MPTCP)
## kernel >= v5.6
https://www.mptcp.dev/
https://github.com/multipath-tcp/mptcp_net-next/wiki

## kernel <= 5.4
https://www.multipath-tcp.org/


