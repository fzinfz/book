<!-- TOC -->

- [Shadowsocks](#shadowsocks)
    - [Docker](#docker)
    - [Multi Users](#multi-users)
    - [Manager/Panel](#managerpanel)
- [ShadowVPN](#shadowvpn)
- [v2ray](#v2ray)
- [Cow - Auto detect blocked sites](#cow---auto-detect-blocked-sites)
- [GO Simple Tunnel](#go-simple-tunnel)
- [goproxy for GAE](#goproxy-for-gae)
- [goproxy with msocks protocal](#goproxy-with-msocks-protocal)
- [LightSword](#lightsword)
- [Other tools](#other-tools)
- [Reversed Proxy](#reversed-proxy)
    - [Google](#google)
- [Optimize](#optimize)
    - [OS / Server side](#os--server-side)
        - [BBR](#bbr)
        - [ServerSpeeder](#serverspeeder)
            - [Supported kernels](#supported-kernels)
    - [Server + Client both sides](#server--client-both-sides)
        - [KCPTun](#kcptun)
        - [Finalspeed](#finalspeed)

<!-- /TOC -->

# Shadowsocks
https://github.com/shadowsocks/shadowsocks/tree/master
https://github.com/shadowsocks/shadowsocks-libev
https://github.com/orvice/shadowsocks-go

https://wiki.archlinux.org/index.php/Shadowsocks
https://shadowsocks.org/en/download/servers.html

## Docker
https://github.com/oddrationale/docker-shadowsocks   
```
docker run -d -p 1984:1984 oddrationale/docker-shadowsocks -s 0.0.0.0 -p 1984 -k $SSPASSWORD -m aes-256-cfb
```

https://github.com/dockerzone/shadowsocks-server  
```
docker pull dockerzone/shadowsocks-server:latest
```

## Multi Users
https://github.com/mengskysama/shadowsocks/tree/manyuser  

## Manager/Panel
https://github.com/orvice/ss-panel  
https://github.com/sendya/shadowsocks-panel
https://github.com/shadowsocks/shadowsocks-manager

# ShadowVPN
https://github.com/OkamiSupport/How-to-build-your-own-private-network

# v2ray
https://www.v2ray.com/chapter_02/01_overview.html
https://toutyrater.github.io/v2ray-guide-pages/
```
docker run -d -v /config.json:/etc/v2ray/config.json v2ray/official/
docker run -dt mritd/v2ray -c ".. http://www.bejson.com/zhuanyi/ .."
```

# Cow - Auto detect blocked sites
https://github.com/cyfdecyf/cow

# GO Simple Tunnel  
https://github.com/ginuerzh/gost  
[PPTP, redsocks, iptables, https/socks5全局上网](https://docs.google.com/document/d/1OGIrebKWq__Lt0ADxprxapevC1BEzPaR6ry9XY_WDdA/edit#heading=h.qh7wl45v71jq)

# goproxy for GAE
https://github.com/phuslu/goproxy/blob/wiki/SimpleGuide.md

# goproxy with msocks protocal
https://github.com/shell909090/goproxy

---
# LightSword
https://github.com/UnsignedInt8/LightSword  
https://medium.com/@UnsignedInt8  

# Other tools
![](https://pbs.twimg.com/media/B6MjT6cCYAA-U3C.png:large)

---
# Reversed Proxy
## Google
https://github.com/bohanyang/onemirror  
OneMirror is a Docker image of Nginx, which already configured Google Search, Google Fonts and Gravatar proxy.
```
docker run -p 80:80 -d bohan/onemirror
```

---
# Optimize

## OS / Server side
https://github.com/iMeiji/shadowsocks_install/wiki/shadowsocks-optimize

### BBR
https://www.1note.win/linux.html#enable-tcp-bbr-of-kernel-49

### ServerSpeeder
```
> Install
wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/serverspeeder/master/serverspeeder-all.sh && bash serverspeeder-all.sh  

> Uninstall
chattr -i /serverspeeder/etc/apx* && /serverspeeder/bin/serverSpeeder.sh uninstall -f

/serverspeeder/bin/serverSpeeder.sh help
```
#### Supported kernels
https://www.91yun.org/serverspeeder91yun  
> CentOS 7.1
* rpm -ivh http://vault.centos.org/7.1.1503/updates/x86_64/Packages/kernel-3.10.0-229.1.2.el7.x86_64.rpm --force
> Ubuntu 14.04
* wget http://security.ubuntu.com/ubuntu/pool/main/l/linux-lts-utopic/linux-image-3.16.0-43-generic_3.16.0-43.58~14.04.1_amd64.deb  && dpkg -i *.deb

## Server + Client both sides

### KCPTun
https://github.com/xtaci/kcptun
./server_linux_amd64 -t "127.0.0.1:8388" -l ":554" -mode fast2  // 转发到服务器的本地8388端口
./client_darwin_amd64 -r "服务器IP地址:554" -l ":8388" -mode fast2 

MIPS32 MSB/LSB version: https://github.com/xtaci/kcptun/issues/29

### Finalspeed
https://blog.kuoruan.com/82.html