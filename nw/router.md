<!-- TOC -->

- [OpenWRT](#openwrt)
    - [V2Ray](#v2ray)

<!-- /TOC -->


# OpenWRT
http://openwrt-dist.sourceforge.net/  
NIC for x86: rtl8139 not detected by default, use e1000.

LAN DHCP: http://192.168.88.18/cgi-bin/luci/admin/network/network/lan  

    vi /etc/config/network
                                                                
        config interface 'wan'
            option ifname 'eth0'
            option proto 'dhcp'

        config interface 'lan'
            option type 'bridge'
            option ifname 'eth1 eth2'
            option proto 'static'
            option ipaddr '192.168.99.1'
            option netmask '255.255.255.0'
            option ip6assign '60'

    /etc/init.d/network restart

set firewall: http://192.168.88.18/cgi-bin/luci/admin/network/firewall  
view iptables: http://192.168.88.18/cgi-bin/luci/admin/status/iptables  
add SSH key: http://192.168.88.18/cgi-bin/luci/admin/system/admin   
view conn list: http://192.168.88.18/cgi-bin/luci/admin/status/realtime/connections  

## V2Ray
https://github.com/kuoruan/luci-app-v2ray

    opkg remove  dnsmasq

https://github.com/kuoruan/openwrt-v2ray  
https://github.com/kuoruan/openwrt-v2ray/releases  
view active config: http://192.168.88.18/cgi-bin/luci/admin/services/v2ray/about

    iptables -t nat -I POSTROUTING -j MASQUERADE

https://github.com/felix-fly/v2ray-openwrt

https://github.com/felix-fly/v2ray-dnsmasq-dnscrypt