# Table of Contents
- [Shadowsocks](#shadowsocks)
- [Lightsword](#lightsword)
- [Optimize](#optimize)


# Shadowsocks
https://github.com/shadowsocks/shadowsocks/tree/master
https://wiki.archlinux.org/index.php/Shadowsocks

Auto install:  
https://github.com/teddysun/shadowsocks_install  
https://github.com/iMeiji/shadowsocks_install

```
#Python version on CentOS
yum install python-setuptools && easy_install pip
pip install shadowsocks

sudo ssserver -p 443 -k password -m aes-256-cfb -d start

#C version on CentOS: https://teddysun.com/357.html  
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-libev.sh  
chmod +x shadowsocks-libev.sh  
./shadowsocks-libev.sh 2>&1 | tee shadowsocks-libev.log

/etc/init.d/shadowsocks status
```
https://gist.github.com/aa65535/ea090063496b0d3a1748

### Docker

https://github.com/oddrationale/docker-shadowsocks   
```
docker run -d -p 1984:1984 oddrationale/docker-shadowsocks -s 0.0.0.0 -p 1984 -k $SSPASSWORD -m aes-256-cfb
```

https://github.com/dockerzone/shadowsocks-server  
```
docker pull dockerzone/shadowsocks-server:latest
```
###Multi Users
https://github.com/mengskysama/shadowsocks/tree/manyuser  
https://github.com/orvice/ss-panel

---
# LightSword
https://github.com/UnsignedInt8/LightSword  
https://medium.com/@UnsignedInt8  
```
#CentOS: https://nodejs.org/en/download/package-manager/#enterprise-linux-and-fedora
curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -  
yum install -y nodejs

npm install lightsword -g

lsserver --password abc123 --port 8081 --method aes-256-cfb --fork --cluster  
lslocal -s server_addr -f   
lsbridge -s server_addr -f  
```
---
# Firewall
```
firewall-cmd --zone=public --add-port=4433/tcp --permanent
firewall-cmd --zone=public --add-port=4433/udp--permanent
firewall-cmd --reload
firewall-cmd --list-all
```
---
# Optimize

## OS
https://github.com/iMeiji/shadowsocks_install/wiki/shadowsocks-optimize

### ServerSpeeder
```
#Install
wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/serverspeeder/master/serverspeeder-all.sh && bash serverspeeder-all.sh  

#Uninstall
chattr -i /serverspeeder/etc/apx* && /serverspeeder/bin/serverSpeeder.sh uninstall -f

/serverspeeder/bin/serverSpeeder.sh help
```
Supported kernels:  https://www.91yun.org/serverspeeder91yun  
```
#CentOS 7.1
rpm -ivh http://vault.centos.org/7.1.1503/updates/x86_64/Packages/kernel-3.10.0-229.1.2.el7.x86_64.rpm --force
```

## Finalspeed

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
