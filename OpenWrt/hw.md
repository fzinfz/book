<!-- TOC -->

- [CN](#cn)
- [OpenWrt One](#openwrt-one)
- [GLiNet](#glinet)
    - [Multi WAN](#multi-wan)

<!-- /TOC -->

# CN
Model|SoC|CPU MHz|Flash MB|RAM MB|Wireless|firmware|Switch
---|---|---|---|---|---|---|---
CT3003 | mt7981 | ? | 128 | 256 | MT7981 | ? | MT7531AE
[AX3200 / AX6S](https://openwrt.org/toh/xiaomi/ax3200)|MediaTek MT7622B|1350|128NAND|256|MT7622B/MT7915E|30720KiB|MT7531BE
RM AX6|Qualcomm IPQ8071A |4C A53 1.4GHz|128 MiB|512||
RM AX3000|Qualcomm IPQ5000|2C A53 1.,0GHz|128 MiB|256||

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

