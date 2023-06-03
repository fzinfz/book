<!-- TOC -->

- [Linux Releases](#linux-releases)
- [Install](#install)
- [Download](#download)
    - [Debian](#debian)
    - [Ubuntu](#ubuntu)
- [Mirrors](#mirrors)
- [Bash](#bash)
    - [tmux](#tmux)
- [Init](#init)
    - [login & non-login shells](#login--non-login-shells)
    - [supervisord](#supervisord)
- [Exit code](#exit-code)
- [Syslog Message Severities](#syslog-message-severities)
- [Signals](#signals)
- [kill](#kill)
- [top](#top)
    - [Glances - A top/htop alternative - Python](#glances---a-tophtop-alternative---python)
- [User & Permission](#user--permission)
    - [add user to group](#add-user-to-group)
    - [password](#password)
    - [sudoers](#sudoers)
    - [chown](#chown)
- [Package Management](#package-management)
    - [Redhat](#redhat)
    - [Ubuntu](#ubuntu)
    - [Debian](#debian)
        - [experimental](#experimental)
    - [dpkg](#dpkg)
    - [apt](#apt)
    - [ssh server](#ssh-server)
- [Grub](#grub)
    - [grub-customizer](#grub-customizer)
    - [boot .iso](#boot-iso)
- [boot repair](#boot-repair)
    - [ubuntu](#ubuntu)
- [Serial](#serial)
    - [client](#client)
- [Benchmark](#benchmark)
- [ssh redirect](#ssh-redirect)
- [web](#web)
    - [wget](#wget)
    - [curl](#curl)
- [files](#files)
    - [find](#find)
    - [grep](#grep)
    - [compress/uncompress](#compressuncompress)
    - [rsync](#rsync)
- [history without line numbers](#history-without-line-numbers)
- [hostname](#hostname)
- [font](#font)
- [SELinux](#selinux)
- [Dropbox](#dropbox)
    - [link account](#link-account)
- [Ubuntu snap](#ubuntu-snap)
    - [Proxy](#proxy)
- [JAVA_HOME](#java_home)
- [I18N & I10N](#i18n--i10n)
- [Chrome](#chrome)
- [AD](#ad)
- [cache diagnostics](#cache-diagnostics)
- [WOL](#wol)
- [Tools - Online](#tools---online)
- [CPU](#cpu)
    - [check_cpu_core_mapping](#check_cpu_core_mapping)
- [USB Persistence](#usb-persistence)
- [kali](#kali)
- [ssh](#ssh)
    - [tools](#tools)
- [Video](#video)
- [OpenCL](#opencl)
- [zFCP](#zfcp)
- [Diagram](#diagram)
- [diskless](#diskless)

<!-- /TOC -->

# Linux Releases

[RHEL](https://access.redhat.com/articles/3078) | 
[Ubuntu](https://en.wikipedia.org/wiki/Ubuntu_version_history#Table_of_versions) | 
[Debian](https://en.wikipedia.org/wiki/Debian_version_history#Release_table)

    6.0	Squeeze	 2.6.32  -> LTS until February 2016
    7	Wheezy   3.2     -> LTS until May 2018
    8	Jessie   3.16    -> LTS until April/May 2020
    9	Stretch	 4.9	 -> LTS until June 2022
    10	Buster   4.19    -> LTS until June 2024
    11	Bullseye 5.10    -> LTS until June 2026

# Install
from existing: https://www.debian.org/releases/stretch/amd64/apds03.html.en

# Download
## Debian
https://cdimage.debian.org/debian-cd/current/amd64/bt-dvd/  

## Ubuntu
http://ftp.sjtu.edu.cn/ubuntu-cd/

http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/mini.iso  
( Mirror only http://us.archive.ubuntu.com/ , need proxy, local DNS not working )

Debug: Console 4 or /var/log/syslog

# Mirrors

    apt install netselect-apt && netselect-apt -c china --nonfree
    mv /etc/apt/sources.list /etc/apt/sources.list.ori && mv sources.list /etc/apt/

# Bash
https://www.gnu.org/software/bash/manual/bash.html

    url=https://raw.githubusercontent.com/fzinfz/scripts/master/init.sh # alias & functions
    source /dev/stdin <<< "$(curl -sS $url)"

    set
        -x                      debug
        -T                      If  set, any traps on DEBUG and RETURN are inherited
        -o functrace/errtrace

    shopt [-pqsu] [-o] [optname …]
        -s: Enable (set) each optname.
        -u: Disable (unset) each optname.

    shopt -s expand_aliases     # when the shell is not interactive
    alias foo='...'

    0: stdin; 1: stdout; 2: stderr              # File descriptor
    2>&1 >/dev/null
    &>/dev/null
    ssh-add 2>/dev/null

https://git.savannah.gnu.org/cgit/bash.git/

## tmux

    ctrl+b x -> kill pane   # /usr/share/doc/tmux/examples/screen-keys.conf
    cat /usr/share/doc/tmux/examples/screen-keys.conf | grep '\bbind \w'

# Init

|Level|Desc|
|---|---|
|0|Halt the system.|
|1|Single-user mode (for special administration).|
|2|Local Multiuser with Networking but without network service (like NFS)|
|3|Full Multiuser with Networking|
|4|Not Used|
|5|Full Multiuser with Networking and X Windows(GUI)|
|6|Reboot.|

    ls -R -l /etc/rc*

    ls -l /usr/lib/systemd      # check `systemd` page for more
    ls -l /usr/share/upstart    # last release 2014; 3 years ago
    ls -l /etc/init.d           # SysV init

    cat /etc/modules-load.d/*

    apt install systemd-sysv    # make link: /sbin/init -> /lib/systemd/systemd

## login & non-login shells
https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html

    login shells：  
        /etc/profile
        ~/.bash_profile(?-> ~/.bashrc), ~/.bash_login, and ~/.profile 
        exit:  ~/.bash_logout

    non-login shells： 
        ~/.bashrc

    # echo $0 : `shopt login_shell` \| $-
    -bash : login_shell on | himBHs
    # bash
    # echo $0 : `shopt login_shell` \| $-
    bash : login_shell off | himBHs
    # bash -c 'echo $0 : `shopt login_shell` \| $-'
    bash : login_shell off | hBc
    
## supervisord
http://supervisord.org/running.html

# Exit code
http://tldp.org/LDP/abs/html/exitcodes.html

    1	Catchall for general errors
    2	Misuse of shell builtins
    126	Command invoked cannot execute
    127	"command not found"	illegal_command	Possible problem with $PATH or a typo
    128+n	Fatal error signal "n"	
        kill -9 $PPID of script	$? returns 137 (128 + 9)
    130	Script terminated by Control-C

# Syslog Message Severities
https://tools.ietf.org/html/rfc5424#section-6.2.1

    0       Emergency: system is unusable
    1       Alert: action must be taken immediately
    2       Critical: critical conditions
    3       Error: error conditions
    4       Warning: warning conditions
    5       Notice: normal but significant condition
    6       Informational: informational messages
    7       Debug: debug-level messages

# Signals
    kill -l
    1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL       5) SIGTRAP
    6) SIGABRT      7) SIGBUS       8) SIGFPE       9) SIGKILL ... 64) SIGRTMAX

# kill
    pkill -KILL -u {username}

# top
    * 1 - Single Cpu       Off (thus multiple cpus)
    * c - Command line     Off (name, not cmdline)
    * i - Idle tasks       On  (show all tasks)
    j - Str align right  Off (not right justify)
    V - Forest view      On  (show as branches)
    f - sort/hide columns
    (`*')  could be overridden through the command-line.

## Glances - A top/htop alternative - Python
https://github.com/nicolargo/glances  

    pip install glances[action,browser,cloud,cpuinfo,chart,docker,export,folders,gpu,ip,raid,snmp,web,wifi]

# User & Permission
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
Free RHEL： https://developers.redhat.com/articles/no-cost-rhel-faq/

    subscription-manager register
    subscription-manager attach --auto
    subscription-manager repos --enable rhel-7-server-optional-rpms
    subscription-manager repos --enable rhel-7-server-extras-rpms
    yum install epel-release
    rm -f /var/run/yum.pid <PID> && yum remove PackageKit

    yum-config-manager --disable c7-media
    yum --nogpgcheck localinstall xx.rpm

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

    # https://mirror.tuna.tsinghua.edu.cn/help/ubuntu/
    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse

## Debian
→ experimental  
→ unstable(Sid) → testing → stable  
Unstable - repository where new & untested packages are introduced.  
Testing - repository with packages from unstable, if no bug are found within 10 days.  

`main` consists of DFSG-compliant packages, which do not rely on software outside this area to operate. These are the only packages considered part of the Debian distribution.  
`contrib` packages contain DFSG-compliant software, but have dependencies not in main (possibly packaged for Debian in non-free).  
`non-free` contains software that does not comply with the DFSG.  

    deb http://mirror.sjtu.edu.cn/debian/ bullseye main contrib non-free

### experimental

    deb http://mirror.sjtu.edu.cn/debian/ experimental main contrib non-free

    apt install -t experimental linux-image-amd64 # latest kernel

## dpkg

    dpkg --get-selections   # list installed

To install .deb manually, visit `linux/kernel` page.

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

## ssh server

    deb http://.../debian/ buster main contrib non-free

    apt install openssh-server # not "openssl"

    # fix： userauth_pubkey: key type ssh-rsa not in PubkeyAcceptedAlgorithms [preauth]
    PubkeyAcceptedAlgorithms  +ssh-rsa

# Grub

    grub2-mkconfig -o /boot/grub2/grub.cfg
    awk -F\' '/menuentry / {print $2}' /boot/grub/grub.cfg
    grub2-set-default 'CentOS Linux (4.9.0-rc8-amd64) 7 (Core)'
    grub2-editenv list

fix: https://www.supergrubdisk.org/category/download/

## grub-customizer
    sudo add-apt-repository ppa:danielrichter2007/grub-customizer
    sudo apt-get update
    sudo apt-get install grub-customizer

## boot .iso
https://netboot.xyz/docs/booting/grub

    apt install grub-imageboot
    mkdir /boot/images && cd /boot/images
    wget https://boot.netboot.xyz/ipxe/netboot.xyz.iso
    update-grub2

# boot repair
https://sourceforge.net/p/boot-repair-cd/home/Home/
    apt install linux-image-*  # if vmlinuz & initrd.img missing

## ubuntu
    sudo add-apt-repository ppa:yannubuntu/boot-repair
    sudo apt-get update
    sudo apt-get install -y boot-repair && boot-repair

# Serial
https://help.ubuntu.com/community/SerialConsoleHowto

    GRUB_CMDLINE_LINUX="console=tty0 console=ttyS0,115200n8"

## client

    screen /dev/ttyUSB0 115200
    picocom -b 115200 /dev/ttyUSB0

# Benchmark
http://www.brendangregg.com/Perf/linux_benchmarking_tools.png
```
    sysbench --test=cpu --cpu-max-prime=20000 --num-threads=32 run

    wget http://www.numberworld.org/y-cruncher/y-cruncher%20v0.7.9.9510-static.tar.xz
    tar -xf y-cruncher*.tar.xz

```

# ssh redirect

    ssh -L 9000:public.com:80   # visit local:9000 -> public.com:80
    ssh -L 0.0.0.0:54321:127.0.0.1:54321 remote -p 22
    ssh -R 9000:localhost:3000  # visit remote:9000 -> local:3000, "GatewayPorts yes" in sshd_config
        -nNT -L ...   # port forwarding only, no shell

# web
## wget 

    wget -O diff_name.zip http://...

## curl

    curl -O http://...
    curl -o diff_name.zip http://

    curl -sSL $1

      -f, --fail          Fail silently (no output at all) on HTTP errors (H)
      -s, --silent        Silent mode (don't output anything)
      -S, --show-error    Show error. With -s, make curl show errors when they occur
      -L, --location      Follow redirects (H)
      -o, --output FILE   Write to FILE instead of stdout
      -O, --remote-name   Write output to a file named as the remote file
      
# files
String replace: http://unix.stackexchange.com/questions/112023/how-can-i-replace-a-string-in-a-files

    apt-get install mlocate
    updatedb
    locate -S
    lsof -p <PID>

    ls --help | grep -E '[-][tr]\b'
    -r, --reverse              reverse order while sorting
                                extension -X, size -S, time -t, version -v
    -t                         sort by modification time, newest first

    mkdir -p /not/existing/folder

    cat > file <<'EOL'
    EOL

    ncdu --exclude='/root/data/*' /

    du -hcd 2  / | more
    du -a / | sort -n -r | head -n 20

    ls -1 $PWD | wc -l  # count files

    file /bin/ps
    ldd /bin/ps
    
## find

    find /home -iname tecmint.txt
    find $1 -iname $2
    # find . ! -readable / -writable / -executabl
    # find . ! -perm -g=w

    find -regextype posix-extended -regex ".*[.](py|sh)" -exec chmod +x {} \;

## grep

    grep --color=auto -rn -P "${regex}" ${path}
    # -r, --recursive           like --directories=recurse
    # -n, --line-number         print line number with output lines
    # -P, --perl-regexp         PATTERN is a Perl regular expression

## compress/uncompress

    gunzip file.gz

    tar -czvf name-of-archive.tar.gz /path/to/directory-or-file # Compress

    tar -tvf my-data.tar.gz '*.py'
    
    tar -zxvf toExtract.tar.gz
    tar -xvf {tarball.tar} {special_file} -C /target/directory

    tar -cf archive.tar foo bar  # Create archive.tar from files foo and bar.
    tar -tvf archive.tar         # List all files in archive.tar verbosely.
    tar -xf archive.tar          # Extract all files from archive.tar.
        -t, --list                 list the contents of an archive
        -j, --bzip2                filter the archive through bzip2
        -c, --create               create a new archive    
        -x, --extract, --get       extract files from an archive    
        -z, --gzip, --gunzip, --ungzip   filter the archive through gzip
        -v, --verbose              verbosely list files processed
        -f, --file=ARCHIVE         use archive file or device ARCHIVE

    zip [options] zipfile files_list
        -r   recurse into directories
        -x   exclude the following names
        -v   verbose operation/print version info

        -m   move into zipfile (delete OS files) !!
        -d   delete entries in zipfile !!!
        -u   update: only changed or new files

    xz --decompress file.xz # -dgrub # unxz

## rsync

    rsync -aP -e "ssh -p $3" $1 root@$2

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

# history without line numbers

    history | cut -c 8-
      -a	append history lines from this session to the history file  ~/.bash_history    

# hostname

    hostnamectl set-hostname GZ2C8G

# font
```
apt-get install  xfonts-base
```

# SELinux
```
getenforce
semanage port -a -t mongod_port_t -p tcp 27017
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

# Tools - Online
http://explainshell.com/  

# CPU

    getconf LONG_BIT

## check_cpu_core_mapping
https://www.ibm.com/support/knowledgecenter/en/SSQPD3_2.6.0/com.ibm.wllm.doc/mappingcpustocore.html  
same physical/core ID  =》 simultaneous multi threads (SMTs) / HT

    cat /proc/cpuinfo  | grep -P 'processor|physical id|core id|^$'

    pip install walnut    # pretty print
    for c in sorted([ ( int(c['processor']), int(c['physical id']), int(c['core id']) ) for c in cpu.dict().values()]): print c

# USB Persistence
https://docs.kali.org/downloading/kali-linux-live-usb-persistence  
http://antix.mepis.org/index.php?title=Using_liveusb_with_persistence  

# kali
x86/M1/Live/VM/WSL/etc: https://www.kali.org/get-kali  
Docker: https://hub.docker.com/u/kalilinux/

# ssh
Since 2022.1: https://www.kali.org/docs/general-use/ssh-configuration/
- kali-tweaks -> Hardening  -> Strong Security (the default) and Wide Compatibility

    ls -l /etc/ssh/ssh_host_*
    systemctl disable regenerate-ssh-host-keys.service

## tools
https://www.kali.org/tools/  
screenshots/cheat sheet: https://www.comparitech.com/net-admin/kali-linux-cheat-sheet/#Kali_Linux_tools    

# Video
https://askubuntu.com/questions/28033/how-to-check-the-information-of-current-installed-video-drivers

    dpkg -l amdgpu-pro
    glxinfo | grep direct
    GALLIUM_HUD=help glxgears

# OpenCL
 installable client driver loader (ICD Loader) may expose multiple separate vendor installable client drivers (Vendor ICDs) for OpenCL.

    sudo apt install ocl-icd-opencl-dev

# zFCP
device driver that supplements the Linux SCSI stack.

![](https://www.ibm.com/support/knowledgecenter/linuxonibm/com.ibm.linux.z.lgdd/lxzfcp.jpg)

# Diagram
![](https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Free_and_open-source-software_display_servers_and_UI_toolkits.svg/1573px-Free_and_open-source-software_display_servers_and_UI_toolkits.svg.png)

# diskless
https://help.ubuntu.com/community/DisklessUbuntuHowto

https://drbl.org/

    docker run --network=host -d leejoneshane/drbl-server

http://web.mst.edu/~vojtat/pegasus/administration.htm     
based on Scientific Linux 7 / CentOS 7 / Red Hat Enterprise Linux 7 