<!-- TOC -->

- [run as Container](#run-as-container)
  - [macvlan - access host](#macvlan---access-host)
  - [ipvlan](#ipvlan)
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

# run as Container
ref: https://mlapp.cn/376.html

    ip link set vlan.10 promisc on
    docker network create -d macvlan --subnet=10.0.0.0/8 --gateway=10.0.0.1 -o parent=vlan.10 macnet
    docker network ls && docker network inspect macnet
    docker run --restart unless-stopped --name openwrt -d --network macnet --privileged sulinggg/openwrt:x86_64 /sbin/init # root/password

```
docker exec -it openwrt /bin/sh # vim /etc/config/network // edit ip/gw & restart

config interface 'lan'
        option type 'bridge'
        option ifname 'eth0'
        option proto 'static'
        option ipaddr '10.19.0.3'
        option netmask '255.0.0.0'
        option gateway '10.0.0.1'
        option broadcast '10.255.255.255'
        option dns '10.0.0.1'

 docker network inspect macnet
```

## macvlan - access host
https://stackoverflow.com/questions/49600665/docker-macvlan-network-inside-container-is-not-reaching-to-its-own-host

    docker network create -d macvlan -o parent=eno1 \
    --subnet 192.168.1.0/24 \
    --gateway 192.168.1.1 \
    --ip-range 192.168.1.192/27 \
    --aux-address 'host=192.168.1.223' \
    mynet

    ip link add macnet-shim link vlan.10 type macvlan  mode bridge
    ip addr add 10.19.0.1/8 dev macnet-shim
    ip link set macnet-shim up
    ip route add 10.0.0.1/8 dev macnet-shim
    ip link show macnet-shim || ip link delete macnet-shim

macvlan/ipvlan: https://sreeninet.wordpress.com/2016/05/29/docker-macvlan-and-ipvlan-network-plugins/

## ipvlan
https://docs.docker.com/network/ipvlan/#ipvlan-l2-mode-example-usage

    docker network  create  -d ipvlan \
        --subnet=10.0.0.0/8 \
        --gateway=10.0.0.1 \
        --ip-range=10.19.1.0/24 \
        -o ipvlan_mode=l2 \
        -o parent=vlan.10 ipvlan10_NotTested

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

* eSir: https://drive.google.com/drive/folders/1uRXg_krKHPrQneI3F2GNcSVRoCgkqESr
* Lenyu: https://drive.google.com/drive/folders/1mckwgy0zpjSpeLR4K3-wjVDAb9gLwRh_

# RM2100
http://openwrt.ink:88/archives/s-breed

# Breed
breed -> openwrt initramfs -> /cgi-bin/luci/admin/system/flashops/sysupgrade
