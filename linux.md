<!-- TOC -->

- [Interactive notes](#interactive-notes)
- [Repository](#repository)
    - [Ubuntu](#ubuntu)
    - [Debian](#debian)
    - [apt](#apt)
    - [deb manually](#deb-manually)
- [Check release & kernel](#check-release--kernel)
- [Grub](#grub)
    - [Ubuntu / Debian](#ubuntu--debian)
    - [CentOS](#centos)
- [Networking](#networking)
    - [Enable TCP BBR of Kernel 4.9](#enable-tcp-bbr-of-kernel-49)
        - [Manually Load and check BBR module(Optional)](#manually-load-and-check-bbr-moduleoptional)
        - [Enable tcp_congestion_control](#enable-tcp_congestion_control)
        - [Check](#check)
    - [Proxy](#proxy)
    - [Firewall](#firewall)
        - [iptables](#iptables)
        - [CentOS](#centos)
        - [Ubuntu 16](#ubuntu-16)
- [Benchmark](#benchmark)
- [vi/vim](#vivim)
- [System](#system)
    - [time](#time)
    - [language](#language)
    - [history without line numbers](#history-without-line-numbers)
    - [ssh](#ssh)
    - [systemctl](#systemctl)
- [Package Management](#package-management)
- [yum](#yum)
- [Files](#files)
- [Dropbox](#dropbox)
    - [link account](#link-account)
- [Nginx](#nginx)
    - [Display file as text](#display-file-as-text)
- [SELinux](#selinux)
- [Storage](#storage)
- [Serial Console](#serial-console)
- [VSphere / ESXi](#vsphere--esxi)
    - [Raw disk mapping (RDM)](#raw-disk-mapping-rdm)
    - [Config](#config)
        - [Backup](#backup)
        - [Restore](#restore)
    - [vmdk](#vmdk)
- [RouterOS](#routeros)

<!-- /TOC -->

# Interactive notes
http://nbviewer.jupyter.org/github/fzinfz/notes/blob/master/linux.ipynb

# Repository
## Ubuntu
Main - Canonical-supported free and open-source software.  
Universe - Community-maintained free and open-source software.  
Restricted - Proprietary drivers for devices.  
Multiverse - Software restricted by copyright or legal issues.  
```
echo deb http://archive.ubuntu.com/ubuntu zesty main  >> /etc/apt/sources.list
```

## Debian
→ experimental  
→ unstable(Sid) → testing → stable  
Debian Unstable - repository where new & untested packages are introduced.  
Debian Testing - repository with packages from unstable, if no bug are found within 10 days.  

main consists of DFSG-compliant packages, which do not rely on software outside this area to operate. These are the only packages considered part of the Debian distribution.  
contrib packages contain DFSG-compliant software, but have dependencies not in main (possibly packaged for Debian in non-free).  
non-free contains software that does not comply with the DFSG.  
```
echo deb http://ftp.debian.org/debian experimental main >> /etc/apt/sources.list
echo deb http://ftp.debian.org/debian jessie-backports main >> /etc/apt/sources.list
```

## apt
```
apt-get update
apt-get install linux-base -t jessie-backports
apt-cache search linux-image | grep 4.9
apt show linux-image-extra-4.9.0-11-generic
```
## deb manually
```
wget http://mirrors.kernel.org/debian/pool/main/l/linux/linux-image-4.9.0-rc8-amd64-unsigned_4.9~rc8-1~exp1_amd64.deb

ar x linux-image-4.9.0-rc8-amd64-unsigned_4.9~rc8-1~exp1_amd64.deb
tar -Jxf data.tar.xz
install -m644 boot/vmlinuz-4.9.0-rc8-amd64 /boot/vmlinuz-4.9.0-rc8-amd64
cp -Rav lib/modules/4.9.0-rc8-amd64 /lib/modules/
depmod -a 4.9.0-rc8-amd64

dracut -f -v --hostonly -k '/lib/modules/4.9.0-rc8-amd64'  /boot/initramfs-4.9.0-rc8-amd64.img 4.9.0-rc8-amd64
```
Ref: https://www.mf8.biz/linux-kernel-with-tcp-bbr/

# Check release & kernel
```
lsb_release -a
uname -a
cat /etc/*-release
```

# Grub
## Ubuntu / Debian
```
awk -F\' '/menuentry / {print $2}' /boot/grub/grub.cfg
vi /etc/default/grub
update-grub
```

## CentOS
```
grub2-mkconfig -o /boot/grub2/grub.cfg
awk -F\' '/menuentry / {print $2}' /boot/grub2/grub.cfg
grub2-set-default 'CentOS Linux (4.9.0-rc8-amd64) 7 (Core)'
grub2-editenv list 
```
# Networking
```
ls -l /sys/class/net/
ip addr show dev eth1
ifconfig ens7 10.99.0.10/16 up
ip addr flush dev eth0
ifconfig eth0 0.0.0.0 0.0.0.0 && dhclient  
dhclient -r eth0
dhclient eth0

tcpdump -i eno16777736 port 27017

nmap -sV -p6379 127.0.0.1
```

## Enable TCP BBR of Kernel 4.9
[docs](./Links.html#tcp-bbr-congestion-based-congestion-control)

### Manually Load and check BBR module(Optional)
```
modprobe tcp_bbr
lsmod | grep bbr
sysctl net.ipv4.tcp_available_congestion_control
```

### Enable tcp_congestion_control
```
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
reboot
```

### Check
```
sysctl net.core.default_qdisc
sysctl net.ipv4 | grep control
tc qdisc show
```

## Proxy
```
export http_proxy=http://10.99.0.100:1080/  
export https_proxy=$http_proxy   
export no_proxy="localhost,127.0.0.1,192.168.*.*,10.*.*.*,172.16.*.*"  
export ftp_proxy=$http_proxy  
export rsync_proxy=$http_proxy
```

## Firewall
### iptables
```
iptables -I INPUT -i docker0 -j ACCEPT
iptables -I INPUT -s  localhost -j ACCEPT

iptables -A INPUT --dport 5355 -j DROP
iptables -A INPUT -p tcp -m multiport  --dport 3306,6379 -j DROP
iptables -A INPUT -p udp --dport 161 -j ACCEPT
iptables-save
iptables -L --line-numbers
iptables -D INPUT 2
```
### CentOS
```
firewall-cmd --permanent --zone=public \
--add-rich-rule="rule family="ipv4" \
source address="1.2.3.4/32" \
port protocol="tcp" port="4567" accept"

firewall-cmd --zone=public --add-port=4433/tcp --permanent
firewall-cmd --zone=public --add-port=4433/udp--permanent
firewall-cmd --reload
firewall-cmd --list-all

service firewalld stop 
```
### Ubuntu 16
```
sudo ufw allow 11200:11299/tcp
sudo ufw status verbose
sudo ufw disable
```

# Benchmark
```
wget http://www.numberworld.org/y-cruncher/y-cruncher%20v0.7.1.9466-static.tar.gz
tar zxvf y-cruncher\ v0.7.1.9466-static.tar.gz 

dd if=/dev/zero of=/root/testfile bs=200M count=1 oflag=direct   
dd if=/dev/zero of=/root/testfile bs=512 count=1000 oflag=direct
```
# vi/vim
```
cw => change word
ciw => change word from cursor
:w !sudo tee % => sudo save
```

# System
## time 
```
sudo timedatectl set-ntp true
TZ='Asia/Shanghai'; export TZ
```

## language
EN: `LC_ALL=C bash`

## history without line numbers  
`history | cut -c 8-`

## ssh
```
ssh-keygen -R hostname
```

## systemctl
https://wiki.archlinux.org/index.php/systemd

```
systemctl status    

systemctl
systemctl --failed

systemctl list-unit-files
systemctl enable xxx

sudo systemctl daemon-reload

SYSTEMD_LESS="FRXMK" journalctl -u docker -n 100
-S, --since=, -U, --until=
```

# Package Management
# yum
yum-config-manager --disable c7-media



# Files
```
cat > file <<'EOL'
EOL

sudo ncdu
sudo du -hcd 2  / | more
sudo  du -a / | sort -n -r | head -n 20
sudo apt-get autoclean
apt --installed list

rsync -aP  /root/_bin root@remote:/root
rsync -aP -e "ssh -p 10220" /root/data/docker-config root@remote:/root/data   --remove-source-files
```
- The ~/.bash_profile would be used once, at login.
- The ~/.bashrc script is read every time a shell is started.

# Dropbox
## link account
`~/.dropbox-dist/dropboxd`  
dropboxd will create a ~/Dropbox folder and start synchronizing it after this step!  
unlink: https://www.dropbox.com/account#security  


# Nginx
## Display file as text
```
location /code/ {
    # All files in it
    location ~* {
        add_header Content-Type text/plain;
    }
}

location /somedir {
        autoindex on;
}
```

# SELinux
```
getenforce
semanage port -a -t mongod_port_t -p tcp 27017
```

# Storage
```
parted -s /dev/vdb mklabel gpt
parted -s /dev/vdb unit mib mkpart primary 0% 100%
mkfs.ext4 /dev/vdb1

mkdir /mnt/blockstorage
echo >> /etc/fstab
echo /dev/vdb1               /mnt/blockstorage       ext4    defaults,noatime 0 0 >> /etc/fstab
mount /mnt/blockstorage
```

# Serial Console
https://wiki.openwrt.org/doc/hardware/port.serial
```
cat openwrt-lantiq-ram-u-boot.asc > /dev/ttyUSB0
screen /dev/ttyUSB0 115200
picocom -b 115200 /dev/ttyUSB0
```

# VSphere / ESXi
## Raw disk mapping (RDM)
```
ls -alh /vmfs/devices/disks
vmkfstools -r /vmfs/devices/disks/<device> example.vmdk
vmkfstools -z /vmfs/devices/disks/<device> example.vmdk
```
[Ref](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1026256)

## Config
[Ref](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=2042141)
### Backup
`vim-cmd hostsvc/firmware/backup_config`
### Restore
```
vim-cmd hostsvc/maintenance_mode_enter
vim-cmd hostsvc/firmware/restore_config /tmp/configBundle.tgz
```
## vmdk
```
vmkfstools -i "source.vmdk" -d thin "destination.vmdk"
```
The tool also reverts a vmdk which was blown up, back into a thin file! ([Ref](http://www.how2blog.de/?p=98))



# RouterOS
put [resolve google.com server 8.8.8.8]