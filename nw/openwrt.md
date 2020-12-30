<!-- TOC -->

- [run as VM](#run-as-vm)
    - [QEMU NIC](#qemu-nic)
- [Web UI](#web-ui)
    - [firewall](#firewall)
    - [iptables](#iptables)
    - [SSH key](#ssh-key)
    - [view conn list](#view-conn-list)
- [/etc/config/](#etcconfig)
    - [firewall](#firewall-1)
    - [network](#network)
- [V2Ray](#v2ray)
- [Download](#download)
    - [x86](#x86)
        - [ipk](#ipk)

<!-- /TOC -->

# run as VM
## QEMU NIC

    use e1000; rtl8139 not detected by default.
    eth0 -> LAN, eth1 -> WAN, usually.

# Web UI
## firewall
http://192.168.88.18/cgi-bin/luci/admin/network/firewall  
## iptables
http://192.168.88.18/cgi-bin/luci/admin/status/iptables  
## SSH key
http://192.168.88.18/cgi-bin/luci/admin/system/admin   
## view conn list
http://192.168.88.18/cgi-bin/luci/admin/status/realtime/connections 

# /etc/config/
## firewall
WAN INPUT -> ACCEPT ; then reboot

## network
https://openwrt.org/docs/guide-user/base-system/basic-networking#network_configuration

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

# V2Ray
https://github.com/kuoruan/luci-app-v2ray

    opkg remove  dnsmasq

https://github.com/kuoruan/openwrt-v2ray  
https://github.com/kuoruan/openwrt-v2ray/releases  
view active config: http://192.168.88.18/cgi-bin/luci/admin/services/v2ray/about

    iptables -t nat -I POSTROUTING -j MASQUERADE

https://github.com/felix-fly/v2ray-openwrt

https://github.com/felix-fly/v2ray-dnsmasq-dnscrypt

# Download
http://openwrt-dist.sourceforge.net/   

## x86
https://drive.google.com/drive/folders/1PsS3c0P7a4A4KY8plQg4Fla8ZI-PGBb1  

### ipk
https://drive.google.com/drive/folders/1PptKkVHiWVcEkSASFulYoJ7NJWxVxwvM