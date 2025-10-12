<!-- TOC -->

- [Chips](#chips)
    - [MediaTek](#mediatek)
- [CN](#cn)
- [OpenWrt One](#openwrt-one)
- [GLiNet](#glinet)
    - [Multi WAN](#multi-wan)

<!-- /TOC -->

# Chips
## MediaTek
https://wikidevi.wi-cat.ru/MediaTek#ARM

- Ethernet switch
    - MT7531AE: 2.5Gbps / SerDes interface
    - MT7531BE: CPU port / RGMII (Reduced Gigabit Media Independent Interface)


MT7981B ds: https://one.openwrt.org/hardware/MT7981B_Wi-Fi6_Platform_Datasheet_Open_V1.0.pdf

# CN
- Xiaomi / Redmi: https://wikidevi.wi-cat.ru/List_of_Xiaomi_Wireless_Devices
- gl-inet: https://wikidevi.wi-cat.ru/GL.iNet

openwrt.org|SoC|CPU MHz|Flash MB|RAM MB|Wireless|Switch
---|---|---|---|---|---|---
[CT3003](https://openwrt.org/toh/hwdata/cetron/cetron_ct3003) | MT7981B | 2c1.3 | 128 | 256 | MT7981 | MT7531AE
[RM AX6S](https://openwrt.org/toh/xiaomi/ax3200)|MT7622B|2c1.35|128NAND|256|MT7622B/MT7915E|MT7531BE
[Mi AX3000T](https://openwrt.org/inbox/toh/xiaomi/ax3000t) | MT7981BA | 2c1.3 | 128NAND | 256 | MT7981BA/MT7976CN | MT7531AE
[GL-MT3000](https://openwrt.org/toh/gl.inet/gl-mt3000) | MT7981BA | 2c1.3 | 256 | 512 | MT7981BA | MT7981BA
[RM AX6](https://openwrt.org/inbox/toh/xiaomi/xiaomi_redmi_ax6_ax3000)|IPQ8071A |4c1.4|128 MiB|512|QCN5024/QCN5054 | QCA8075
[GL-MT6000](https://openwrt.org/toh/gl.inet/gl-mt6000)  | MT7986A | 4c2.0 | 8G eMMC | 1024 | MT7976GN/MT7976AN | MT7531AE

# OpenWrt One
November 29, 2024: https://openwrt.org/#openwrt_one_router_officially_launched

MT7981B / 2C 1.3GHz / 1G + 256MB / LAN: 2.5G + 1G : https://openwrt.org/toh/openwrt/one

# GLiNet
GL-MT6000 | eth1 + ( eth0 : lan1-5 )

    ls -lh /etc/oui-tertf/client.db
    /etc/config

API: https://dev.gl-inet.com/

Cloud Web: set firewall/lan subnet/ ; view clients
- CN : https://cloud.gl-inet.cn
- https://www.goodcloud.xyz
- remote web/terminal : need pub ip? : https://docs.gl-inet.com/router/en/4/interface_guide/cloud/#remote-access-web-admin-panel



## Multi WAN
no custom rules on luci

- wan
- secondwan
- wwan
- tethering | USB | https://docs.gl-inet.com/router/en/4/interface_guide/internet_tethering/

        cat /etc/config/kmwan

            option level # TODO

        cat /etc/hotplug.d/iface/99-kmwan

        uci -q get kmwan.global.enable

sensitivity: detection time interval(unit:s)

