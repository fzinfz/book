<!-- TOC -->

- [Shadowsocks](#shadowsocks)
- [xray](#xray)
- [v2ray](#v2ray)
    - [with router](#with-router)
- [hysteria - Go](#hysteria---go)
- [naiveproxy](#naiveproxy)
- [Brook - Go](#brook---go)
- [fastd](#fastd)
- [tinc](#tinc)
- [Manager](#manager)
- [Panel](#panel)
- [Docker](#docker)
- [Cow - Auto detect blocked sites](#cow---auto-detect-blocked-sites)
- [Optimize](#optimize)
    - [BBR (Kernel 4.9+)](#bbr-kernel-49)
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
- [Clients](#clients)
    - [clash](#clash)
        - [Premium](#premium)
        - [Tap](#tap)
        - [Web UI](#web-ui)
    - [sing-box](#sing-box)
- [Management](#management)
    - [Web](#web)
    - [CLI](#cli)
- [Subscription](#subscription)
- [VPN](#vpn)
- [Host Apps](#host-apps)

<!-- /TOC -->

# Shadowsocks
- [Official](https://github.com/shadowsocks/) | 
- [Compare](https://github.com/shadowsocks/shadowsocks/wiki/Feature-Comparison-across-Different-Versions)
- ([raw](https://raw.githubusercontent.com/wiki/shadowsocks/shadowsocks/Feature-Comparison-across-Different-Versions.md)) 
- haproxy https://lvii.gitbooks.io/outman/content/ss.haproxy.html
- shadow-tls: https://github.com/ihciah/shadow-tls/wiki/Example-Compose

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

- 配置指南 https://toutyrater.github.io/v2ray-guide-pages/  
- https://github.com/ToutyRater/v2ray-guide/blob/master/basic/vmess.md

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

# hysteria - Go
- https://github.com/apernet/hysteria
- Clinets: https://hysteria.network/zh/docs/installation/
- Full Config: https://hysteria.network/zh/docs/advanced-usage/

# naiveproxy
https://github.com/klzgrad/naiveproxy

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

# Clients
https://www.v2ray.com/awesome/tools.html  
iOS free: OneClick、Leaf | https://itlanyan.com/get-proxy-clients/#bnp_i_2

## clash
https://github.com/Dreamacro/clash  
Rules: https://github.com/snapei/clash-pro-rules

### Premium
Download: https://github.com/Dreamacro/clash/releases/tag/premium  
Guide： 
- https://github.com/Dreamacro/clash/wiki/Clash-Premium-Features  
- https://docs.cfw.lbyczf.com/contents/tap.html

### Tap
.dll to clash folder: https://www.wintun.net/

### Web UI
- TS: https://github.com/Dreamacro/clash-dashboard
  - forked: https://github.com/haishanh/yacd/
- TS + Rust: https://github.com/zzzgydi/clash-verge

## sing-box
https://sing-box.sagernet.org/features/

# Management
## Web
- Xray/Trojan-Go/Hysteria/NaiveProxy: https://github.com/trojanpanel/install-script
- vmess、vless、trojan、shadowsocks、dokodemo-door、socks、http
    - https://github.com/vaxilu/x-ui
    - https://hub.docker.com/r/enwaiax/x-ui

## CLI
- mack-a: https://raw.githubusercontent.com/mack-a/v2ray-agent/master/install.sh

# Subscription
- convert/merge: https://github.com/tindy2013/subconverter/blob/master/README-docker.md

    docker run -d --restart=unless-stopped -p 25500:25500 tindy2013/subconverter:latest

https://github.com/tindy2013/subconverter/blob/master/README-cn.md#%E8%BF%9B%E9%98%B6%E7%94%A8%E6%B3%95

http://192.168.1.25:25500/sub?target=clash&url=http%3A%2F%2F192.168.88.19%3A88%2Fxray.txt

    %3A : 
    %2F /

# VPN
- Cloudflare WARP: https://1.1.1.1/
    - WARP+ | $4.99/month or less , +1GB per share
- Private Cloud: [/nw/VPN/](/nw/VPN/)

# Host Apps
- Win | ssh : MobaXterm
- Linux : 
    - env: https://wiki.archlinux.org/title/Proxy_server
    - [tsocks](/nw/proxy_socks/#tsocks)
    - proxychains： `apt install -y proxychains && vi /etc/proxychains.conf`

