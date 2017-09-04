<!-- TOC -->

- [Shell](#shell)
- [Interactive notes](#interactive-notes)
- [Diagram](#diagram)
- [Repository](#repository)
- [Package Management](#package-management)
    - [Redhat](#redhat)
        - [EPEL](#epel)
    - [Ubuntu](#ubuntu)
    - [Debian](#debian)
    - [yum](#yum)
    - [apt](#apt)
    - [deb manually](#deb-manually)
- [Check release & kernel](#check-release--kernel)
    - [CentOS](#centos)
- [Benchmark](#benchmark)
- [vi/vim](#vivim)
- [System](#system)
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
- [Files](#files)
- [SELinux](#selinux)
- [Serial Console](#serial-console)
- [X](#x)
- [ANDROID](#android)
- [Dropbox](#dropbox)
    - [link account](#link-account)

<!-- /TOC -->

# Shell
http://explainshell.com/
https://www.netsarang.com/xshell_download.html

# Interactive notes
http://nbviewer.jupyter.org/github/fzinfz/notes/blob/master/linux.ipynb

# Diagram
![](https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Free_and_open-source-software_display_servers_and_UI_toolkits.svg/1573px-Free_and_open-source-software_display_servers_and_UI_toolkits.svg.png)

# Repository
# Package Management
## Redhat
```
subscription-manager register
subscription-manager attach --auto
subscription-manager repos --enable rhel-7-server-optional-rpms
subscription-manager repos --enable rhel-7-server-extras-rpms
yum install epel-release
rm -f /var/run/yum.pid <PID> && yum remove PackageKit
```
Free RHEL： https://developers.redhat.com/articles/no-cost-rhel-faq/ 

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

## yum
```
yum-config-manager --disable c7-media
```

## apt
```
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

## CentOS
```
grub2-mkconfig -o /boot/grub2/grub.cfg
awk -F\' '/menuentry / {print $2}' /boot/grub2/grub.cfg
grub2-set-default 'CentOS Linux (4.9.0-rc8-amd64) 7 (Core)'
grub2-editenv list 
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

# Dropbox
## link account
`~/.dropbox-dist/dropboxd`  
dropboxd will create a ~/Dropbox folder and start synchronizing it after this step!  
unlink: https://www.dropbox.com/account#security  