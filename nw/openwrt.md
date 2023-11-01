<!-- TOC -->

- [CLI](#cli)
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
- [network](#network)
    - [DSA](#dsa)
    - [/etc/config/](#etcconfig)
- [QoS](#qos)
    - [SQM](#sqm)
    - [nftables](#nftables)
- [Tailscale](#tailscale)
- [Mesh](#mesh)
    - [bat-adv](#bat-adv)
    - [Mode 802.11s](#mode-80211s)
    - [Mode AP - 802.11r](#mode-ap---80211r)
- [MediaTek](#mediatek)
- [Switch Chip](#switch-chip)
    - [Bridged AP Setup](#bridged-ap-setup)
- [Controller - OpenWISP](#controller---openwisp)
- [Compile](#compile)
    - [Version](#version)
- [MTD](#mtd)
- [uboot](#uboot)
- [Hardware](#hardware)
- [ImmortalWrt](#immortalwrt)

<!-- /TOC -->

# CLI

    cat /tmp/dhcp.leases

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

# network
## DSA
replace swconfigc

Multiple networks (using VLANs): https://forum.openwrt.org/t/mini-tutorial-for-dsa-network-config/96998

## /etc/config/
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

- config : https://openwrt.org/docs/guide-user/network/wifi/basic#neighbor_reports_options_80211k
  - helper: https://github.com/walidmadkour/OpenWRT-UCI-helper-802.11r
  - uci: https://vicfree.com/2022/11/openwrt-wpa3-802.11kvr-ap-setup/
- [debug](https://forum.openwrt.org/t/any-way-to-monitor-if-802-11r-is-working/73504): [hostapd log](https://openwrt.org/docs/guide-developer/debugging#logging_hostapd_behaviour)

# MediaTek 
https://github.com/coolsnowwolf/lede/issues/5002#issuecomment-683371787

    grep -E 'RRM|WNM|Ft' * # k/v/r

# Switch Chip
https://openwrt.org/docs/techref/swconfig

    swconfig list
    swconfig dev switch0 show

## Bridged AP Setup

Web URI | Task
-- | --
/luci/admin/network/vlan | + vlan : all ports tagged
/luci/admin/network/iface_add | test new vlan IP ; lan : remove dhcp

# Controller - OpenWISP
- Install: https://github.com/openwisp/openwisp-controller#deploy-it-in-production
- Features: https://openwisp.org/whatis.html
- Config: https://openwisp.io/docs/user/configure-device.html#install-openwisp-config

# Compile

    git clone --single-branch --branch main   --depth 1 https://github.com/openwrt/openwrt.git  /data/github/openwrt
    git clone --single-branch --branch 22.03  --depth 1 https://github.com/Lienol/openwrt.git   /data/github/openwrt-Lienol-22.03
    git clone --single-branch --branch master --depth 1 https://github.com/coolsnowwolf/lede    /data/github/openwrt-lede

https://hub.docker.com/r/p3terx/openwrt-build-env


    docker run -itd \
        --name openwrt-build \
        -v /data/github/openwrt:/home/user/openwrt \
        p3terx/openwrt-build-env

    n=openwrt-build-lede
    docker exec $n sudo chown -hR user:user . && docker exec -it $n bash # tmux
    cd ~/openwrt && ls -la
    # make clean # rm /bin /build_dir
    ./scripts/feeds update -a ; ./scripts/feeds install -a
    make menuconfig # make targetclean
    make download -j8 V=s && make V=s -j$(($(nproc) - 1))
    

    ls /data/github/openwrt*/bin/targets/mediatek/mt7622/*.bin -lh # host
    

https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem


LuCI ---> Applications ---> luci-app-mtwifi #闭源Wi-Fi驱动 + kmod-mt76...
Extra packages ---> ipv6helper

## Version

    CONFIG_VERSIONOPT=y
    CONFIG_IMAGEOPT=y
    CONFIG_VERSION_DIST="##.##-SNAPSHOT"
    CONFIG_VERSION_NUMBER="OpenWrt"

# MTD
calc HEX -> DEC ： 
00400000 = 4MiB
06f00000 = 111MiB

# uboot
https://github.com/hanwckf/bl-mt798x

# Hardware

Model|SoC|CPU MHz|Flash MB|RAM MB|Wireless|firmware|Switch
---|---|---|---|---|---|---|---
CT3003 | mt7981 | ? | 128 | 256 | MT7981 | ? | MT7531AE
[AX3200 / AX6S](https://openwrt.org/toh/xiaomi/ax3200)|MediaTek MT7622B|1350|128NAND|256|MT7622B/MT7915E|30720KiB|MT7531BE
RM AX6|Qualcomm IPQ8071A |4C A53 1.4GHz|128 MiB|512||
RM AX3000|Qualcomm IPQ5000|2C A53 1.,0GHz|128 MiB|256||

# ImmortalWrt
- https://github.com/immortalwrt/immortalwrt
- https://firmware-selector.immortalwrt.org