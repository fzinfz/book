<!-- TOC -->

- [Check release & kernel](#check-release--kernel)
- [Kernel 4.9](#kernel-49)
    - [Ubuntu / Debian](#ubuntu--debian)
        - [Debian Official](#debian-official)
- [Grub](#grub)
    - [Ubuntu / Debian](#ubuntu--debian)
- [Enable TCP BBR of Kernel 4.9](#enable-tcp-bbr-of-kernel-49)
    - [Manually Load and check BBR module(Optional)](#manually-load-and-check-bbr-moduleoptional)
    - [Enable tcp_congestion_control temporarily](#enable-tcp_congestion_control-temporarily)
    - [Enable tcp_congestion_control permanently](#enable-tcp_congestion_control-permanently)
    - [Check](#check)
- [Docker](#docker)
    - [Install(kernel>=3.10)](#installkernel310)
- [vi/vim](#vivim)
- [System](#system)
    - [time](#time)
    - [history without line numbers](#history-without-line-numbers)
    - [systemctl](#systemctl)
- [Files](#files)
- [Dropbox](#dropbox)
    - [link account](#link-account)
- [Networking L2/L3](#networking-l2l3)
- [Proxy](#proxy)
- [SELinux](#selinux)
- [Firewall](#firewall)
    - [iptables](#iptables)
    - [CentOS](#centos)
    - [Ubuntu 16](#ubuntu-16)
- [Nginx](#nginx)
    - [Display file as text](#display-file-as-text)
- [Storage](#storage)
- [VSphere / ESXi](#vsphere--esxi)
    - [Raw disk mapping (RDM)](#raw-disk-mapping-rdm)
    - [Config](#config)
        - [Backup](#backup)
        - [Restore](#restore)
    - [vmdk](#vmdk)
- [Serial Console](#serial-console)

<!-- /TOC -->

# Check release & kernel
```
lsb_release -a
uname -a
cat /etc/*-release
```
# Kernel 4.9
## Ubuntu / Debian
```
mkdir kernel-4.9 && cd kernel-4.9

wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.9/linux-headers-4.9.0-040900_4.9.0-040900.201612111631_all.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.9/linux-headers-4.9.0-040900-generic_4.9.0-040900.201612111631_amd64.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.9/linux-image-4.9.0-040900-generic_4.9.0-040900.201612111631_amd64.deb

sudo dpkg -i *.deb
```
Tested on Debian 8.6 and Ubuntu 16.10.
### Debian Official
```
echo  "deb http://ftp.de.debian.org/debian experimental main"  >>  /etc/apt/sources.list
apt-get update && apt-cache search linux-image-4.9
```

# Grub
## Ubuntu / Debian
```
awk -F\' '/menuentry / {print $2}' /boot/grub/grub.cfg
vi /etc/default/grub
update-grub
reboot
```

# Enable TCP BBR of Kernel 4.9
[docs](./Links#tcp-bbr-congestion-based-congestion-control)
## Manually Load and check BBR module(Optional)
```
modprobe tcp_bbr
lsmod | grep bbr
sysctl net.ipv4.tcp_available_congestion_control
```
## Enable tcp_congestion_control temporarily
`sysctl -w net.ipv4.tcp_congestion_control=bbr`
## Enable tcp_congestion_control permanently
```
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
```
## Check
```
sysctl net.ipv4 | grep control
tc qdisc show
```

# Docker
## Install(kernel>=3.10)
```
curl -fsSL https://get.docker.com/ | sh
sudo systemctl enable docker.service
sudo systemctl start docker
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

## history without line numbers  
`history | cut -c 8-`

## systemctl
https://wiki.archlinux.org/index.php/systemd

```
systemctl status    

systemctl
systemctl --failed

systemctl list-unit-files
systemctl enable xxx
```

# Files
```
sudo ncdu
sudo du -hcd 2  / | more
sudo  du -a / | sort -n -r | head -n 20
sudo apt-get autoclean

dd if=/dev/zero of=/root/testfile bs=1G count=1 oflag=direct    
dd if=/dev/zero of=/root/testfile bs=512 count=1000 oflag=direct
```
- The ~/.bash_profile would be used once, at login.
- The ~/.bashrc script is read every time a shell is started.

# Dropbox
## link account
`~/.dropbox-dist/dropboxd`  
dropboxd will create a ~/Dropbox folder and start synchronizing it after this step!  
unlink: https://www.dropbox.com/account#security  

# Networking L2/L3
```
ls -l /sys/class/net/
ip addr show dev eth1
ifconfig ens7 10.99.0.10/16 up
ip addr flush dev eth0
ifconfig eth0 0.0.0.0 0.0.0.0 && dhclient  
dhclient -r eth0
dhclient eth0

tcpdump -i eno16777736 port 27017
```

# Proxy
```
export http_proxy=http://192.168.4.10:7778/  
export https_proxy=$http_proxy   
export no_proxy="localhost,127.0.0.1,192.168.*.*,10.*.*.*,172.16.*.*"  
export ftp_proxy=$http_proxy  
export rsync_proxy=$http_proxy
```

# SELinux
```
getenforce
semanage port -a -t mongod_port_t -p tcp 27017
```

# Firewall
## iptables
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
## CentOS
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
## Ubuntu 16
```
ufw allow 11200:11299/tcp
```

# Nginx
## Display file as text
```
location /code/ {
    # All files in it
    location ~* {
        add_header Content-Type text/plain;
    }
}
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

# Serial Console
https://wiki.openwrt.org/doc/hardware/port.serial
```
cat openwrt-lantiq-ram-u-boot.asc > /dev/ttyUSB0
screen /dev/ttyUSB0 115200
picocom -b 115200 /dev/ttyUSB0
```