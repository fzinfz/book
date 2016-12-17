<!-- TOC -->

- [Cow - Auto detect blocked sites](#cow---auto-detect-blocked-sites)
- [GO Simple Tunnel](#go-simple-tunnel)
- [Shadowsocks](#shadowsocks)
    - [Auto install](#auto-install)
    - [Python version on CentOS](#python-version-on-centos)
    - [C version on CentOS](#c-version-on-centos)
    - [Docker](#docker)
    - [Multi Users](#multi-users)
    - [Manager/Panel](#managerpanel)
- [LightSword](#lightsword)
    - [CentOS](#centos)
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
- [introspectable tunnels to localhost](#introspectable-tunnels-to-localhost)

<!-- /TOC -->

# Cow - Auto detect blocked sites
https://github.com/cyfdecyf/cow

# GO Simple Tunnel  
https://github.com/ginuerzh/gost  
[PPTP, redsocks, iptables, https/socks5全局上网](https://docs.google.com/document/d/1OGIrebKWq__Lt0ADxprxapevC1BEzPaR6ry9XY_WDdA/edit#heading=h.qh7wl45v71jq)

# Shadowsocks
https://github.com/shadowsocks/shadowsocks/tree/master
https://wiki.archlinux.org/index.php/Shadowsocks

## Auto install  
https://github.com/teddysun/shadowsocks_install  
https://github.com/iMeiji/shadowsocks_install

## Python version on CentOS
```
yum install python-setuptools && easy_install pip
pip install shadowsocks

sudo ssserver -p 443 -k password -m aes-256-cfb -d start
```

## C version on CentOS  
https://teddysun.com/357.html  
```
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-libev.sh  
chmod +x shadowsocks-libev.sh  
./shadowsocks-libev.sh 2>&1 | tee shadowsocks-libev.log

/etc/init.d/shadowsocks status
```
https://gist.github.com/aa65535/ea090063496b0d3a1748

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
https://github.com/orvice/ss-panel

## Manager/Panel
https://github.com/orvice/ss-panel  
https://github.com/sendya/shadowsocks-panel

docker pull gyteng/ssmgr


---
# LightSword
https://github.com/UnsignedInt8/LightSword  
https://medium.com/@UnsignedInt8  

## CentOS
https://nodejs.org/en/download/package-manager/#enterprise-linux-and-fedora
```
curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -  
yum install -y nodejs

npm install lightsword -g

lsserver --password abc123 --port 8081 --method aes-256-cfb --fork --cluster  
lsserver -d stop
lslocal -s server_addr -f   
lsbridge -s server_addr -f  
```
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
```
service iptables start  
iptables -I INPUT -p tcp --dport ssh端口号 -j ACCEPT  
iptables -I OUTPUT -p tcp --sport ssh端口号 -j ACCEPT  
service iptables save

wget  https://soft.kuoruan.com/finalspeed/install_fs.sh  
chmod +x install_fs.sh  
./install_fs.sh 2>&1 | tee install.log

mkdir -p /fs/cnf/ ; echo 新端口号 > /fs/cnf/listen_port ; sh /fs/restart.sh

chmod +x /etc/rc.local  
echo sh /fs/start.sh >> /etc/rc.local

crontab -e  	
0 3 * * * sh /fs/restart.sh
```

# introspectable tunnels to localhost
https://github.com/inconshreveable/ngrok
https://github.com/fzinfz/gortcp