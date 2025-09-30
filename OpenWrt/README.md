- [Install on X86](#install-on-x86)
- [run as Container](#run-as-container)
    - [macvlan - access host](#macvlan---access-host)
    - [ipvlan](#ipvlan)
- [run as VM](#run-as-vm)
    - [QEMU NIC](#qemu-nic)
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
- [Switch Chip](#switch-chip)
    - [Bridged AP Setup](#bridged-ap-setup)
- [Controller - OpenWISP](#controller---openwisp)
- [Compile](#compile)
    - [Version](#version)
- [Mi](#mi)
- [Hardware](#hardware)
- [ImmortalWrt](#immortalwrt)


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

# network
## DSA
replace swconfig

Multiple networks (using VLANs): https://forum.openwrt.org/t/mini-tutorial-for-dsa-network-config/96998

## /etc/config/
https://openwrt.org/docs/guide-user/network/network_configuration#example_configuration

        config interface 'wan'
            option ifname 'eth0'
            option proto 'dhcp'
            option 'defaultroute' '1' # if multi WAN

        config interface 'lan'
            option type 'bridge'
            option ifname 'eth1 eth2'
            option proto 'static'
            option ipaddr '192.168.99.1'
            option netmask '255.255.255.0'
            option ip6assign '60'

    /etc/init.d/network restart

    # Soft network reload
    service network reload
    
    # Hard network restart
    service network restart

H/W Router: wireless interfaces may be added to lan automatically via LUCI, create new for other bridges.

# QoS
## SQM
https://openwrt.org/docs/guide-user/network/traffic-shaping/start

https://openwrt.org/docs/guide-user/network/traffic-shaping/sqm
- Interface name to your internet (WAN) link
- Link Layer Adaptation: https://openwrt.org/docs/guide-user/network/traffic-shaping/sqm-details#sqmlink_layer_adaptation_tab

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
[./wireless.md#80211kvr](./wireless.md#80211kvr)

# Switch Chip
https://openwrt.org/docs/techref/swconfig

    swconfig list
    swconfig dev switch0 show

    VLAN 1:
            vid: 1
            ports: 0 1 6  # 6 = untagged CPU
    VLAN 10:  # luci： `/network/vlan`
            vid: 10
            ports: 2 3 6t # tag CPU => create `eth0.X`(eth0=switch0) under `/network/iface_add`

https://openwrt.org/docs/guide-user/network/vlan/switch_configuration#vlan_explained_with_default_scenario_of_most_openwrt_routers
- Each port `untagged` to exactly one VLAN ID

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

# Mi
- AX3200 (RB01, international) = Redmi AX6S (RB03, Chinese)
    - https://openwrt.org/toh/xiaomi/ax3200  
    - https://github.com/mikeeq/xiaomi_ax3200_openwrt
- AX6 : https://github.com/InfinityTL/OpenWrt-Redmi-AX6  
- AX3000: https://github.com/shell-script/unlock-redmi-ax3000  
- RM2100: http://openwrt.ink:88/archives/s-breed
- AX3000T / Win CMD: https://github.com/zc360/Xiaomi-ax3000t-openwrt
    - https://note.okhk.net/xiaomi-ax3000t-router-with-hanwckf-immortalwrt
    - back to stock: https://www.kaitaku.xyz/misc/ax3000t-openwrt/#%E6%81%A2%E5%A4%8D%E5%8E%9F%E5%8E%82-uboot
    - WR30U: https://zhuanlan.zhihu.com/p/659735701 | https://github.com/hanwckf/bl-mt798x


# ImmortalWrt
- https://github.com/immortalwrt/immortalwrt
- https://firmware-selector.immortalwrt.org