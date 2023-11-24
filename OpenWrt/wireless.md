- [802.11kvr](#80211kvr)
    - [/etc/config/wireless](#etcconfigwireless)
    - [MediaTek](#mediatek)
- [Client Info](#client-info)
- [Controller](#controller)
    - [DAWN](#dawn)

# 802.11kvr
[/nw/README.md#roaming---80211krv](/nw/README.md#roaming---80211krv)

## /etc/config/wireless
https://openwrt.org/docs/guide-user/network/wifi/basic#neighbor_reports_options_80211k
- helper: https://github.com/walidmadkour/OpenWRT-UCI-helper-802.11r
- uci: https://vicfree.com/2022/11/openwrt-wpa3-802.11kvr-ap-setup/
- [debug](https://forum.openwrt.org/t/any-way-to-monitor-if-802-11r-is-working/73504): [hostapd log](https://openwrt.org/docs/guide-developer/debugging#logging_hostapd_behaviour)

        # grep -E '11(k|v|r)|^config' /etc/config/wireless
        config wifi-device 'radio0'
        config wifi-iface 'default_radio0'
                option ieee80211r '1'
                option ieee80211k '1'
                # option ieee80211v Removed

## MediaTek
https://github.com/coolsnowwolf/lede/issues/5002#issuecomment-683371787

        grep -E 'RRM|WNM|Ft' -r /etc/wireless/ # k/v/r

# Client Info
http://wrt.lan/cgi-bin/luci/admin/network/wireless

        # fping -g 192.168.8.0/24 # show IPv4 if IPv6 under `Associated Stations`

        # iw dev | grep -E 'Interface|ssid'

        # iw dev phy1-ap0 station dump
        Station [K60_MAC] (on phy1-ap0)
                inactive time:  10 ms
                rx bytes:       1274880
                rx packets:     7828
                tx bytes:       56193821
                tx packets:     39844
                tx retries:     8088
                tx failed:      8088
                rx drop misc:   6
                signal:         -83 [-86, -91, -86, -95] dBm
                signal avg:     -82 [-86, -91, -86, -95] dBm
                tx bitrate:     432.3 MBit/s 160MHz HE-MCS 2 HE-NSS 2 HE-GI 0 HE-DCM 0
                tx duration:    21709248 us
                rx bitrate:     432.3 MBit/s 160MHz HE-MCS 2 HE-NSS 2 HE-GI 0 HE-DCM 0
                rx duration:    542587 us
                last ack signal:-12 dBm
                avg ack signal: -22 dBm
                airtime weight: 256
                authorized:     yes
                authenticated:  yes
                associated:     yes
                preamble:       short
                WMM/WME:        yes
                MFP:            no
                TDLS peer:      no
                DTIM period:    2
                beacon interval:100
                short preamble: yes
                short slot time:yes
                connected time: 87 seconds
                associated at [boottime]:       283658.981s
                associated at:  1700846966098 ms
                current time:   1700847053027 ms

# Controller
## DAWN
Decentralized WiFi Controller
- https://github.com/berlin-open-wireless-lab/DAWN
- https://openwrt.org/docs/guide-user/network/wifi/dawn