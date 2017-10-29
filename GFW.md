<!-- TOC -->

- [Shadowsocks](#shadowsocks)
- [v2ray](#v2ray)
- [Transparent Proxy](#transparent-proxy)
- [中文手册](#中文手册)
    - [V2ray](#v2ray)
    - [Shadowsocks](#shadowsocks-1)
- [Manager](#manager)
- [Panel](#panel)
- [Docker](#docker)
- [Cow - Auto detect blocked sites](#cow---auto-detect-blocked-sites)
- [Optimize](#optimize)
    - [BBR (Kernel 4.9+)](#bbr-kernel-49)
    - [KCPTun](#kcptun)
    - [dragonite-java](#dragonite-java)
    - [UDPspeeder](#udpspeeder)
- [Reversed Proxy](#reversed-proxy)
    - [Google](#google)
- [govpn](#govpn)
- [HTTP tunnel in Go: goflyway](#http-tunnel-in-go-goflyway)
- [Other tools](#other-tools)
- [LightSword](#lightsword)
- [ShadowVPN](#shadowvpn)
- [GO Simple Tunnel](#go-simple-tunnel)
- [goproxy for GAE](#goproxy-for-gae)
- [goproxy with msocks protocal](#goproxy-with-msocks-protocal)
- [tinyFecVPN](#tinyfecvpn)

<!-- /TOC -->

# Shadowsocks
[Official](https://github.com/shadowsocks/) | 
[Compare](https://github.com/shadowsocks/shadowsocks/wiki/Feature-Comparison-across-Different-Versions)
([raw](https://raw.githubusercontent.com/wiki/shadowsocks/shadowsocks/Feature-Comparison-across-Different-Versions.md)) 

# v2ray
https://www.v2ray.com/chapter_02/01_overview.html  
https://toutyrater.github.io/v2ray-guide-pages/

# Transparent Proxy
https://github.com/sorz/moproxy  
https://www.v2ray.com/chapter_02/protocols/dokodemo.html  
https://github.com/shadowsocks/shadowsocks-libev#advanced-usage

# 中文手册
## V2ray
https://toutyrater.github.io/

## Shadowsocks
https://lvii.gitbooks.io/outman/content/ss.client.html  
https://neroxps.gitbooks.io/compile-shadowsocks-rss-libev/content/  
https://github.com/softwaredownload/openwrt-fanqiang

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
https://github.com/fzinfz/scripts/blob/master/bbr_enable.sh

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

# Reversed Proxy
## Google
https://github.com/bohanyang/onemirror  
OneMirror is a Docker image of Nginx, which already configured Google Search, Google Fonts and Gravatar proxy.
```
docker run -p 80:80 -d bohan/onemirror
```

# govpn
http://www.cypherpunks.ru/govpn/

# HTTP tunnel in Go: goflyway
https://github.com/coyove/goflyway

# Other tools
https://pbs.twimg.com/media/B6MjT6cCYAA-U3C.png:large

# LightSword
https://github.com/UnsignedInt8/LightSword  
https://medium.com/@UnsignedInt8  

# ShadowVPN
https://github.com/OkamiSupport/How-to-build-your-own-private-network

# GO Simple Tunnel  
https://github.com/ginuerzh/gost  
[PPTP, redsocks, iptables, https/socks5全局上网](https://docs.google.com/document/d/1OGIrebKWq__Lt0ADxprxapevC1BEzPaR6ry9XY_WDdA/edit#heading=h.qh7wl45v71jq)

# goproxy for GAE
https://github.com/phuslu/goproxy/blob/wiki/SimpleGuide.md

# goproxy with msocks protocal
https://github.com/shell909090/goproxy

# tinyFecVPN
https://github.com/wangyu-/tinyFecVPN