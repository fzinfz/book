<!-- TOC -->

- [alias, functions and notes](#alias-functions-and-notes)
- [top](#top)
- [Exit code](#exit-code)
- [File descriptor](#file-descriptor)
- [Diagram](#diagram)
- [X11](#x11)
    - [Forwarding](#forwarding)
    - [add user to group](#add-user-to-group)
    - [password](#password)
    - [sudoers](#sudoers)
    - [chown](#chown)
- [Package Management](#package-management)
    - [Redhat](#redhat)
        - [EPEL](#epel)
    - [Ubuntu](#ubuntu)
        - [CN mirrors](#cn-mirrors)
    - [Debian](#debian)
    - [yum](#yum)
    - [dpkg](#dpkg)
    - [apt](#apt)
- [Grub](#grub)
- [Benchmark](#benchmark)
- [wget/curl](#wgetcurl)
    - [curl github](#curl-github)
- [files](#files)
    - [tar](#tar)
    - [rsync](#rsync)
    - [compress/uncompress](#compressuncompress)
- [time](#time)
- [history without line numbers](#history-without-line-numbers)
- [font](#font)
- [systemctl](#systemctl)
- [SELinux](#selinux)
- [Serial Console](#serial-console)
- [X](#x)
- [Dropbox](#dropbox)
    - [link account](#link-account)
- [Ubuntu snap](#ubuntu-snap)
    - [Proxy](#proxy)
- [pip](#pip)
    - [Proxy](#proxy-1)
    - [Installing from local](#installing-from-local)
    - [boot repair](#boot-repair)
    - [ubuntu](#ubuntu)
- [modules](#modules)
- [JAVA_HOME](#java_home)
- [I18N & I10N](#i18n--i10n)
- [Chrome](#chrome)
- [Proxy](#proxy-2)
- [AD](#ad)
- [cache diagnostics](#cache-diagnostics)
- [WOL](#wol)
- [tools](#tools)
- [USB Persistence](#usb-persistence)

<!-- /TOC -->

# alias, functions and notes
https://github.com/fzinfz/scripts/blob/master/init.sh  
http://nbviewer.jupyter.org/github/fzinfz/notes/blob/master/linux.ipynb

    !!    # sudo last command

# top
    * 1 - Single Cpu       Off (thus multiple cpus)
    * c - Command line     Off (name, not cmdline)
    * i - Idle tasks       On  (show all tasks)
    j - Str align right  Off (not right justify)
    V - Forest view      On  (show as branches)
    f - sort/hide columns
    (`*')  could be overridden through the command-line.

# Exit code
http://tldp.org/LDP/abs/html/exitcodes.html

    1	Catchall for general errors
    2	Misuse of shell builtins
    126	Command invoked cannot execute
    127	"command not found"	illegal_command	Possible problem with $PATH or a typo
    128+n	Fatal error signal "n"	
        kill -9 $PPID of script	$? returns 137 (128 + 9)
    130	Script terminated by Control-C

# File descriptor
    0: stdin; 1: stdout; 2: stderr
    2>&1 >/dev/null
    ssh-add 2>/dev/null

# Diagram
![](https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Free_and_open-source-software_display_servers_and_UI_toolkits.svg/1573px-Free_and_open-source-software_display_servers_and_UI_toolkits.svg.png)

# X11
## Forwarding
https://wiki.archlinux.org/index.php/Secure_Shell#X11_forwarding

    AllowTcpForwarding yes
    X11Forwarding yes
    X11DisplayOffset 10
    X11UseLocalhost yes

## add user to group
    sudo adduser foobar www-data
    sudo usermod -a -G ftp tony

## password
    echo user:pwd | chpasswd

## sudoers
    sudo visudo
        root    ALL=(ALL) ALL # {terminals}=({users}) {commands}
        %supergroup  ALL=(ALL) NOPASSWD:ALL

## chown
    chown -h myuser:mygroup mysymbolic

# Package Management
## Redhat
    subscription-manager register
    subscription-manager attach --auto
    subscription-manager repos --enable rhel-7-server-optional-rpms
    subscription-manager repos --enable rhel-7-server-extras-rpms
    yum install epel-release
    rm -f /var/run/yum.pid <PID> && yum remove PackageKit

Free RHEL： https://developers.redhat.com/articles/no-cost-rhel-faq/ 

### EPEL
http://elrepo.org/tiki/tiki-index.php

    rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
    rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
    yum install yum-plugin-fastestmirror
    yum --enablerepo=elrepo-kernel install kernel-ml

## Ubuntu
Main - Canonical-supported free and open-source software.  
Universe - Community-maintained free and open-source software.  
Restricted - Proprietary drivers for devices.  
Multiverse - Software restricted by copyright or legal issues.  

### CN mirrors
https://mirror.tuna.tsinghua.edu.cn/help/ubuntu/

    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse

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
    yum-config-manager --disable c7-media
    yum --nogpgcheck localinstall xx.rpm

## dpkg
    dpkg --get-selections

## apt
```
apt-get install linux-base -t jessie-backports
apt-cache search linux-image | grep linux-image-4
apt install linux-image-4.10.0-9-generic linux-image-extra-4.10.0-9-generic

apt show linux-image-extra-4.10*

apt-get install --only-upgrade docker-engine

apt policy docker-ce | head -n 20

apt-get autoclean
apt list --installed

rm -r /var/lib/apt/lists/*
```

# Grub
    grub2-mkconfig -o /boot/grub2/grub.cfg
    awk -F\' '/menuentry / {print $2}' /boot/grub2/grub.cfg
    grub2-set-default 'CentOS Linux (4.9.0-rc8-amd64) 7 (Core)'
    grub2-editenv list

# Benchmark
http://www.brendangregg.com/Perf/linux_benchmarking_tools.png
```
sysbench --test=cpu --cpu-max-prime=20000 --num-threads=32 run

wget http://www.numberworld.org/y-cruncher/y-cruncher%20v0.7.1.9466-static.tar.gz
tar zxvf y-cruncher\ v0.7.1.9466-static.tar.gz 
```

# wget/curl
    wget -O diff_name.zip http://...
    curl -O http://...
    curl -o diff_name.zip http://

## curl github
https://github.com/settings/tokens

    curl -H 'Authorization: token INSERT_ACCESS_TOKEN_HERE' \
        -H 'Accept: application/vnd.github.v3.raw' -O -L \
        https://api.github.com/repos/owner/repo/contents/path

# files
- The ~/.bash_profile would be used once, at login.
- The ~/.bashrc script is read every time a shell is started.

String replace: http://unix.stackexchange.com/questions/112023/how-can-i-replace-a-string-in-a-files

    apt-get install mlocate
    updatedb
    locate -S
    lsof -p <PID>

    ls --help | grep -E '[-][tr]\b'
    -r, --reverse              reverse order while sorting
                                extension -X, size -S, time -t, version -v
    -t                         sort by modification time, newest first

    find /home -iname tecmint.txt

    mkdir -p /not/existing/folder

    cat > file <<'EOL'
    EOL

    ncdu --exclude='/root/data/*' /

    du -hcd 2  / | more
    du -a / | sort -n -r | head -n 20

    ls -1 $PWD | wc -l  # count files

## tar
    tar -xvf {tarball.tar} {special_file}

    -j : filter archive through bzip2, use to decompress .bz2 files.
    -z: filter archive through gzip, use to decompress .gz files.

    -x: instructs tar to extract files.
    -t: List the contents of an archive.

    -v: Verbose (show progress while extracting files).
    -f: specifies filename / tarball name.

## rsync
    rsync -aP  /root/_bin root@remote:/root
    rsync -aP -e "ssh -p 10220" /local root@remote:/dir   --remove-source-files
        -v, --verbose               increase verbosity
        -a, --archive               archive mode; equals -rlptgoD (no -H,-A,-X)
            --no-OPTION             turn off an implied OPTION (e.g. --no-D)
        -r, --recursive             recurse into directories
        -l, --links                 copy symlinks as symlinks
        -p, --perms                 preserve permissions
        -o, --owner                 preserve owner (super-user only)
        -g, --group                 preserve group
        -D                          same as --devices --specials
        -t, --times                 preserve modification times
        -S, --sparse                handle sparse files efficiently
        -e, --rsh=COMMAND           specify the remote shell to use
            --partial               keep partially transferred files
            --partial-dir=DIR       put a partially transferred file into DIR
        -z, --compress              compress file data during the transfer
            --progress              show progress during transfer
        -P                          same as --partial --progress

## compress/uncompress
    tar -zcvf new.tar.gz directory-name

    tar -ztvf my-data.tar.gz
    tar -tvf my-data.tar.gz
    tar -tvf my-data.tar.gz '*.py'

    tar -zxvf toExtract.tar.gz

    gunzip file.gz

# time
```
sudo timedatectl set-ntp true
TZ='Asia/Shanghai'; export TZ
```

# history without line numbers
`history | cut -c 8-`

# font
```
apt-get install  xfonts-base
```

# systemctl
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

# Dropbox
## link account
`~/.dropbox-dist/dropboxd`  
dropboxd will create a ~/Dropbox folder and start synchronizing it after this step!  
unlink: https://www.dropbox.com/account#security  

# Ubuntu snap
run without `root`
## Proxy
    vi /etc/environment
    systemctl restart snapd

# pip
## Proxy
    export all_proxy="socks5://x:y" # cause python error: Missing dependencies for SOCKS support.
    pip install --proxy=https://user@mydomain:port  somepackage

## Installing from local
    pip install --download DIR -r requirements.txt
    pip wheel --wheel-dir DIR -r requirements.txt
    pip install --no-index --find-links=DIR -r requirements.txt

## boot repair
https://sourceforge.net/p/boot-repair-cd/home/Home/
    apt install linux-image-*  # if vmlinuz & initrd.img missing

## ubuntu
    sudo add-apt-repository ppa:yannubuntu/boot-repair
    sudo apt-get update
    sudo apt-get install -y boot-repair && boot-repair

# modules
/etc/modules-load.d/modules.conf # boot load

# JAVA_HOME
    echo export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk" >> /etc/profile

# I18N & I10N
    apt install -y locales-all
    locale -a
    dpkg-reconfigure locales

    yum grouplist chinese-support

    sudo apt-get install -y ttf-wqy-microhei  #文泉驿-微米黑
    sudo apt-get install -y ttf-wqy-zenhei  #文泉驿-正黑
    sudo apt-get install -y xfonts-wqy #文泉驿-点阵宋体

# Chrome
    chromium --no-sandbox # start as root

# Proxy
    export http_proxy=http://proxy_ip:1080
    export https_proxy=http://proxy_ip:1080

    sudo apt install -y proxychains
    vi /etc/proxychains.conf

# AD
https://wiki.samba.org/index.php/Setting_up_Samba_as_an_NT4_PDC_(Quick_Start)

# cache diagnostics 
https://hoytech.com/vmtouch/

    git clone https://github.com/hoytech/vmtouch.git
    cd vmtouch && make && sudo make install

    Discovering which files your OS is caching
    Telling the OS to cache or evict certain files or regions of files
    Locking files into memory so the OS won't evict them
    Preserving virtual memory profile when failing over servers
    Keeping a "hot-standby" file-server
    Plotting filesystem cache usage over time
    Maintaining "soft quotas" of cache usage
    Speeding up batch/cron jobs

# WOL
    ethtool enp1s0  | grep Wake-on

    p (PHY activity)
    u (unicast activity)
    m (multicast activity)
    b (broadcast activity)
    g (magic packet activity) *
    a (ARP activity)
    d (disabled)

# tools
http://explainshell.com/  
https://www.netsarang.com/xshell_download.html  
https://mobaxterm.mobatek.net/features.html  

# USB Persistence
https://docs.kali.org/downloading/kali-linux-live-usb-persistence  
http://antix.mepis.org/index.php?title=Using_liveusb_with_persistence  