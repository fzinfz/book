<!-- TOC -->

- [Interactive notes](#interactive-notes)
- [Repository](#repository)
    - [Redhat](#redhat)
        - [EPEL](#epel)
    - [Ubuntu](#ubuntu)
    - [Debian](#debian)
    - [apt](#apt)
    - [deb manually](#deb-manually)
- [Check release & kernel](#check-release--kernel)
- [Grub](#grub)
    - [Ubuntu / Debian](#ubuntu--debian)
        - [VT-d](#vt-d)
        - [QEMU](#qemu)
        - [vagrant](#vagrant)
    - [CentOS](#centos)
- [Networking](#networking)
    - [Enable TCP BBR of Kernel 4.9](#enable-tcp-bbr-of-kernel-49)
        - [Manually Load and check BBR module(Optional)](#manually-load-and-check-bbr-moduleoptional)
        - [Enable tcp_congestion_control](#enable-tcp_congestion_control)
        - [Check](#check)
    - [Proxy](#proxy)
    - [Firewall](#firewall)
        - [iptables](#iptables)
        - [CentOS](#centos-1)
        - [Ubuntu 16](#ubuntu-16)
- [Benchmark](#benchmark)
- [vi/vim](#vivim)
- [System](#system)
    - [CPU](#cpu)
    - [disk](#disk)
        - [mkpart, format, mount](#mkpart-format-mount)
        - [Convert between MBR and GPT](#convert-between-mbr-and-gpt)
        - [LVM](#lvm)
        - [Swap](#swap)
    - [files](#files)
    - [time](#time)
    - [language](#language)
    - [history without line numbers](#history-without-line-numbers)
    - [ssh](#ssh)
    - [password](#password)
    - [font](#font)
    - [systemctl](#systemctl)
- [Package Management](#package-management)
- [yum](#yum)
- [Files](#files)
- [Openstack](#openstack)
    - [Ubuntu](#ubuntu-1)
- [Dropbox](#dropbox)
    - [link account](#link-account)
- [Nginx](#nginx)
    - [Display file as text](#display-file-as-text)
- [SELinux](#selinux)
- [Serial Console](#serial-console)
- [VSphere / ESXi](#vsphere--esxi)
    - [Raw disk mapping (RDM)](#raw-disk-mapping-rdm)
    - [Config](#config)
        - [Backup](#backup)
        - [Restore](#restore)
- [RouterOS](#routeros)
- [X](#x)
- [ANDROID](#android)
- [PHP](#php)
- [QCloud](#qcloud)

<!-- /TOC -->

# Interactive notes
http://nbviewer.jupyter.org/github/fzinfz/notes/blob/master/linux.ipynb

# Repository
## Redhat
```
subscription-manager register
subscription-manager attach --auto
subscription-manager repos --enable rhel-7-server-optional-rpms
subscription-manager repos --enable rhel-7-server-extras-rpms
yum install epel-release
rm -f /var/run/yum.pid <PID> && yum remove PackageKit
```

### EPEL
http://elrepo.org/tiki/tiki-index.php
```
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
yum install yum-plugin-fastestmirror
yum --enablerepo=elrepo-kernel install kernel-ml
```
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
apt-cache search linux-image | grep linux-image-4
apt install linux-image-4.10.0-9-generic linux-image-extra-4.10.0-9-generic

apt show linux-image-extra-4.10*

apt-get install --only-upgrade docker-engine

apt policy docker-ce | head -n 20
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

### VT-d
```
GRUB_CMDLINE_LINUX_DEFAULT="intel_iommu=on modprobe.blacklist=ahci,radeon,nouveau,nvidiafb,snd_hda_intel"
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash amd_iommu=on"


lspci -nn 
lspci -nnk -d 8086:1521 
-nn		Show both textual and numeric ID's (names & numbers)
-k		Show kernel drivers handling each device

add IOMMU GROUP

echo '0000:42:00.1' | sudo tee /sys/bus/pci/devices/0000:42:00.1/driver/unbind
echo 8086 1d02 | sudo tee /sys/bus/pci/drivers/vfio-pci/new_id
```

### QEMU
```
systool -m kvm_intel -v | grep nested

virsh domxml-to-native qemu-argv demo.xml > demo.sh

cat > demo.args <<EOF
LC_ALL=C PATH=/bin HOME=/home/test USER=test \
LOGNAME=test /usr/bin/qemu -S -M pc -m 214 -smp 1 \
-nographic -monitor pty -no-acpi -boot c -hda \
/dev/HostVG/QEMUGuest1 -net none -serial none \
-parallel none -usb
EOF

virsh domxml-from-native qemu-argv demo.args > demo.xml

virsh list --all

vi /etc/libvirt/qemu/VM_NAME.xml

  <features>
    ...
    <kvm>
      <hidden state='on'/>
    </kvm>
  </features>

  <qemu:commandline>                                              
  <qemu:arg value='-set'/>                                          
  <qemu:arg value='device.hostdev0.x-vga=on'/>      
  </qemu:commandline>


```

### vagrant
```
sudo apt-get install vagrant 
sudo apt-get install libz-dev
vagrant plugin install vagrant-mutate
vagrant mutate http://files.vagrantup.com/precise32.box libvirt
vagrant plugin install vagrant-libvirt

vagrant plugin install vagrant-lxc

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

echo 'check tcp-segmentation-offload, generic-segmentation/receive-offload status'
ethtool -k ens3
ethtool -K ens3 gro off gso off tso off

```

http://darkk.net.ru/redsocks/


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
http://www.brendangregg.com/Perf/linux_benchmarking_tools.png
```
sysbench --test=cpu --cpu-max-prime=20000 --num-threads=32 run

wget http://www.numberworld.org/y-cruncher/y-cruncher%20v0.7.1.9466-static.tar.gz
tar zxvf y-cruncher\ v0.7.1.9466-static.tar.gz 
```
# vi/vim
```
cw => change word
ciw => change word from cursor
:w !sudo tee % => sudo save
```

# System
## disk
### mkpart, format, mount
```
parted -s /dev/sdb mklabel gpt
parted -s /dev/sdb unit mib mkpart primary 0% 100%
mkfs.ext4 /dev/sdb1
mkdir /data
echo >> /etc/fstab
echo /dev/vdb1               /root/data       ext4    defaults,noatime 0 0 >> /etc/fstab
mount /root/data
```

### Convert between MBR and GPT
```
sudo sgdisk -g /dev/sda
sudo sgdisk -m /dev/sda
sudo partprobe -s
```

### LVM
```
pvs
pvdisplay -v -m
lvcreate -L 80G ubuntu-vg -n data
```

### Swap
```
swapoff -v /dev/mapper/ubuntu--vg-swap_1
lvm lvreduce /dev/mapper/ubuntu--vg-swap_1 -L -19G
mkswap /dev/mapper/ubuntu--vg-swap_1
swapon -va

echo /dev/VG/LV swap swap defaults 0 0 >> /etc/fstab
```

## files
```
apt-get install mlocate
updatedb
locate -S
lsof -p <PID>
```
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
sudo apt-get install openssh-server 

ssh-keygen -R hostname
```

## password
```
echo user:pwd | chpasswd
```

## font
```
apt-get install  xfonts-base
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
apt list --installed

rsync -aP  /root/_bin root@remote:/root
rsync -aP -e "ssh -p 10220" /root/data/docker-config root@remote:/root/data   --remove-source-files
```
- The ~/.bash_profile would be used once, at login.
- The ~/.bashrc script is read every time a shell is started.

# Openstack
## Ubuntu
```
sudo apt-add-repository ppa:juju/stable
sudo apt-add-repository ppa:conjure-up/next
sudo apt update && sudo apt install -y conjure-up &&  conjure-up
```

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


# RouterOS
put [resolve google.com server 8.8.8.8]

# X
```
vncserver -kill :1
```


# ANDROID
```
miflash lock: 
fastboot oem edl
fastboot oem edl-reboot

adb push filename /sdcard/.
```

# PHP
https://getcomposer.org/doc/01-basic-usage.md
```
curl -sS https://getcomposer.org/installer | php && \
php composer.phar  install && \
php composer.phar update
```
https://getcomposer.org/doc/articles/versions.md
~1.2.3 is equivalent to >=1.2.3 <1.3.0
^1.2.3 is equivalent to >=1.2.3 <2.0.0

# QCloud
/usr/local/sa/agent
/usr/local/qcloud/monitor/barad/admin
