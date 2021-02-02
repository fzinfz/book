<!-- TOC -->

- [run as VM](#run-as-vm)
    - [QEMU NIC](#qemu-nic)
- [Web UI](#web-ui)
    - [firewall](#firewall)
    - [iptables](#iptables)
    - [SSH key](#ssh-key)
    - [view conn list](#view-conn-list)
- [/etc/config/](#etcconfig)
    - [network](#network)
- [QoS](#qos)
    - [SQM](#sqm)
    - [nftables](#nftables)
- [Download](#download)
- [RM2100](#rm2100)
- [Breed](#breed)

<!-- /TOC -->

# run as VM
## QEMU NIC

    use e1000; rtl8139 not detected by default.
    eth0 -> LAN, eth1 -> WAN, usually.

# Web UI
## firewall
/cgi-bin/luci/admin/network/firewall  
## iptables
/cgi-bin/luci/admin/status/iptables  
## SSH key
/cgi-bin/luci/admin/system/admin   
## view conn list
/cgi-bin/luci/admin/status/realtime/connections 

# /etc/config/
## network
https://openwrt.org/docs/guide-user/base-system/basic-networking#network_configuration
                                  
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

H/W Router: wireless interfaces may be added to lan automatically via LUCI, create new for other bridges.

# QoS
## SQM
https://openwrt.org/docs/guide-user/network/traffic-shaping/start

## nftables
https://github.com/openwrt/packages/blob/master/net/nft-qos/files/nft-qos.config

# Download
- Pure: http://openwrt-dist.sourceforge.net/   
- QoS/VPNs: https://firmware.koolshare.cn/LEDE_X64_fw867/ 

* eSir: https://drive.google.com/drive/folders/1dqNUrMf9n7i3y1aSh68U5Yf44WQ3KCuh
* Lenyu: https://drive.google.com/drive/folders/1mckwgy0zpjSpeLR4K3-wjVDAb9gLwRh_

# RM2100
http://openwrt.ink:88/archives/s-breed

# Breed
breed -> openwrt initramfs -> /cgi-bin/luci/admin/system/flashops/sysupgrade
