<!-- TOC -->

- [CLI](#cli)
- [Packages](#packages)
- [Install on X86](#install-on-x86)
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
- [Tailscale](#tailscale)
- [Mesh](#mesh)
    - [bat-adv](#bat-adv)
    - [Mode 802.11s](#mode-80211s)
    - [Mode AP - 802.11r](#mode-ap---80211r)
- [Controller - OpenWISP](#controller---openwisp)

<!-- /TOC -->

# CLI

    cat /tmp/dhcp.leases

# Packages
base image: [/nw/hw/](/nw/hw/)

https://op.supes.top/packages/

# Install on X86
https://openwrt.org/docs/guide-user/installation/openwrt_x86

    dd if=openwrt-21.02.0-x86-64-generic-ext4-combined.img bs=1M of=/dev/sdX

    opkg update
    opkg install lsblk parted losetup resize2fs
    echo fix | parted -l ---pretend-input-tty
    parted -s /dev/sda resizepart 2 100% 
    losetup /dev/loop1 /dev/sda2
    resize2fs -f /dev/loop1

# run as Container
- https://supes.top/docker%E7%89%88openwrt%E6%97%81%E8%B7%AF%E7%94%B1%E5%AE%89%E8%A3%85%E8%AE%BE%E7%BD%AE%E6%95%99%E7%A8%8B/
- https://mlapp.cn/376.html

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

# Tailscale
- https://github.com/adyanth/openwrt-tailscale-enabler
- https://openwrt.org/docs/guide-user/services/vpn/tailscale/start
# Mesh

    iw list | grep -E "phy|mesh" # check if supported hardware

## bat-adv
https://cgomesu.com/blog/Mesh-networking-openwrt-batman/#initial-configuration

    opkg remove wpad-basic-
    opkg install batctl-full kmod-batman-adv wpad-mesh-wolfssl

https://www.open-mesh.org/doc/batman-adv/Batman-adv-openwrt-config.html

## Mode 802.11s
https://openwrt.org/docs/guide-user/network/wifi/mesh/80211s

## Mode AP - 802.11r
https://www.adrian.idv.hk/2022-11-27-80211r/
- needs both the AP and the station to support
- ESS = all BSSID(MAC) of same SSID
- mobility domain = subset of ESS that allows station to roam around
    - R0KH: controller as the PMK-R0 key holder 
    - R1KH: APs as the PMK-R1 key holder
    - S0KH and S1KH, S for supplicant: station are the PMK-S0 key holder and PMK-S1 key holder

# Controller - OpenWISP
- Install: https://github.com/openwisp/openwisp-controller#deploy-it-in-production
- Features: https://openwisp.org/whatis.html
- Config: https://openwisp.io/docs/user/configure-device.html#install-openwisp-config
