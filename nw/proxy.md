<!-- TOC -->

- [clash](#clash)
    - [config](#config)
- [WireGuard - C](#wireguard---c)
    - [tailscale](#tailscale)
- [nebula - go](#nebula---go)
- [zerotier](#zerotier)
- [Shadowsocks](#shadowsocks)
- [xray](#xray)
- [v2ray](#v2ray)
    - [with router](#with-router)
- [hysteria](#hysteria)
- [Brook - Go](#brook---go)
- [fastd](#fastd)
- [tinc](#tinc)
- [Transparent Proxy](#transparent-proxy)
- [中文手册](#%E4%B8%AD%E6%96%87%E6%89%8B%E5%86%8C)
    - [V2ray](#v2ray)
    - [Shadowsocks](#shadowsocks)
- [Manager](#manager)
- [Panel](#panel)
- [Docker](#docker)
- [Cow - Auto detect blocked sites](#cow---auto-detect-blocked-sites)
- [Optimize](#optimize)
    - [BBR Kernel 4.9+](#bbr-kernel-49)
    - [KCPTun](#kcptun)
    - [dragonite-java](#dragonite-java)
    - [UDPspeeder](#udpspeeder)
- [govpn](#govpn)
- [HTTP tunnel in Go: goflyway](#http-tunnel-in-go-goflyway)
- [LightSword](#lightsword)
- [ShadowVPN](#shadowvpn)
- [gohop VPN - go](#gohop-vpn---go)
- [GO Simple Tunnel](#go-simple-tunnel)
- [goproxy for GAE](#goproxy-for-gae)
- [goproxy with msocks protocal](#goproxy-with-msocks-protocal)
- [tinyFecVPN](#tinyfecvpn)
- [Subscription URL Generator](#subscription-url-generator)
- [OpenWRT](#openwrt)

<!-- /TOC -->

# clash
https://github.com/Dreamacro/clash  
Premium: https://github.com/Dreamacro/clash/releases/tag/premium  

## config
https://github.com/magicdawn/clash-config-manager  
https://github.com/snapei/clash-pro-rules  
sub merge: https://acl4ssr-sub.github.io/

# WireGuard - C
https://www.wireguard.com/quickstart/  
https://wiki.archlinux.org/title/WireGuard  
Userspace: https://github.com/masipcat/wireguard-go-docker  

## tailscale
Free for Personal: https://tailscale.com/pricing/  

    curl -fsSL https://tailscale.com/install.sh | sh
    sysctl -w net.ipv4.ip_forward=1
    sysctl -w net.ipv6.conf.all.forwarding=1
    tailscale up --advertise-exit-node # enable on WebUI: Edit route settings
    tailscale status

Official: https://login.tailscale.com/admin/machines  
Custom: https://tailscale.com/kb/1118/custom-derp-servers/

# nebula - go
https://github.com/slackhq/nebula

# zerotier

    curl -s https://install.zerotier.com | sudo bash
    service zerotier-one status
    zerotier-cli status

# Shadowsocks
[Official](https://github.com/shadowsocks/) | 
[Compare](https://github.com/shadowsocks/shadowsocks/wiki/Feature-Comparison-across-Different-Versions)
([raw](https://raw.githubusercontent.com/wiki/shadowsocks/shadowsocks/Feature-Comparison-across-Different-Versions.md)) 

# xray
https://github.com/XTLS/  
https://hub.docker.com/r/teddysun/xray

https://github.com/rprx/v2fly-github-io/blob/master/docs/config/protocols/vless.md#%E5%AE%A2%E6%88%B7%E7%AB%AF%E6%8C%87%E5%BC%95

    Qv2ray（v2.6.3+），支持 Linux、macOS、Windows
    v2rayN（v3.21+），支持 Windows
    v2rayNG（v1.3.0+），支持 Android
    PassWall（v3.9.35+），支持 OpenWrt
    v2rayA（v1.0.0+），支持 Linux, Web UI
    v2rayU（v3.0.0+），支持 macOS

# v2ray
https://www.v2ray.com/chapter_02/01_overview.html  
https://github.com/v2ray/manual/blob/master/zh_cn/chapter_02/protocols/vmess.md

https://toutyrater.github.io/v2ray-guide-pages/  
https://github.com/ToutyRater/v2ray-guide/blob/master/basic/vmess.md

loglevel： "debug"、"info"、"warning"、"error" 和 "none"

    "inbound": {
        "protocol": "http",
        "port":8123,
        "settings": {
            "timeout": 0
        }
    },
    "inbound": {
        "port": 1080,           // 本地监听端口
        "listen": "0.0.0.0",
        "protocol": "socks",    // 使用 Socks(5) 传入协议
        "settings": {
            "auth": "noauth",     // 不认证
            "udp": false,         // 不开启 UDP 转发
            "ip": "127.0.0.1"     // 当开启 UDP 时，V2Ray 需要知道本机的 IP 地址
        }
    },

## with router
https://blog.zichao.io/2018/03/03/v2ray-on-vyos.html

# hysteria
https://github.com/HyNetwork/hysteria

# Brook - Go
https://github.com/txthinking/brook

# fastd
https://projects.universe-factory.net/projects/fastd/wiki  

    deb http://ftp.de.debian.org/debian sid main
    deb https://repo.universe-factory.net/debian/ sid main

https://nilsschneider.net/2013/02/17/fastd-tutorial.html  
https://github.com/digineo/fastd

# tinc
https://www.tinc-vpn.org/

# Transparent Proxy
https://github.com/shadowsocks/shadowsocks-libev#advanced-usage  
Check `Networking` page for more.

# 中文手册
## V2ray
https://toutyrater.github.io/

## Shadowsocks
https://lvii.gitbooks.io/outman/content/ss.client.html  
https://neroxps.gitbooks.io/compile-shadowsocks-rss-libev/content/  

# Manager
https://github.com/fzinfz/ssmanager-nopanel

# Panel
https://hub.docker.com/r/fzinfz/ss-panel/

# Docker
https://hub.docker.com/r/fzinfz/ss/

```
docker run -d -v /config.json:/etc/v2ray/config.json v2ray/official/  
docker run -dt mritd/v2ray -c "..encode with http://www.bejson.com/zhuanyi/ .."
```

# Cow - Auto detect blocked sites
https://github.com/cyfdecyf/cow

# Optimize
https://github.com/iMeiji/shadowsocks_install/wiki/shadowsocks-optimize

## BBR (Kernel 4.9+)

    curl https://raw.githubusercontent.com/fzinfz/scripts/master/bbr_enable.sh | bash

## KCPTun
https://github.com/xtaci/kcptun
```
./server_linux_amd64 -t "127.0.0.1:8388" -l ":554" -mode fast2  // 转发到服务器的本地8388端口
./client_darwin_amd64 -r "服务器IP地址:554" -l ":8388" -mode fast2 
```

## dragonite-java
https://github.com/dragonite-network/dragonite-java

## UDPspeeder
https://github.com/wangyu-/UDPspeeder

# govpn
http://www.cypherpunks.ru/govpn/

# HTTP tunnel in Go: goflyway
https://github.com/coyove/goflyway

# LightSword
https://github.com/UnsignedInt8/LightSword  
https://medium.com/@UnsignedInt8  

# ShadowVPN
https://github.com/OkamiSupport/How-to-build-your-own-private-network

# gohop VPN - go
https://github.com/bigeagle/gohop

# GO Simple Tunnel
https://github.com/ginuerzh/gost  

# goproxy for GAE
https://github.com/phuslu/goproxy/blob/wiki/SimpleGuide.md

# goproxy with msocks protocal
https://github.com/shell909090/goproxy

# tinyFecVPN
https://github.com/wangyu-/tinyFecVPN

# Subscription URL Generator
https://sub-web.netlify.app/

# OpenWRT
https://github.com/immortalwrt/immortalwrt