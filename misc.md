<!-- TOC -->

- [vi/vim](#vivim)
- [UEFI Shell](#uefi-shell)
- [Hardware](#hardware)
    - [CPUID to arch](#cpuid-to-arch)
    - [CPU flag](#cpu-flag)
    - [RS232 3pin](#rs232-3pin)
- [MySQL Cluster](#mysql-cluster)
- [Excel](#excel)
- [Sync](#sync)
- [Instant Notifications](#instant-notifications)
- [IoT](#iot)
- [taobao](#taobao)
- [ANDROID](#android)
    - [miflash unlock](#miflash-unlock)

<!-- /TOC -->

# vi/vim
    :%s/pattern/replace/g_  # i/I: case in/sensitive
    cw => change word
    ciw => change word from cursor
    :w !sudo tee %      ===> sudo save

# UEFI Shell
https://software.intel.com/en-us/articles/uefi-shell

    map # list disks
    help bcfg

# Hardware
## CPUID to arch
https://github.com/mer-tools/oprofile/blob/master/libop/op_hw_specific.h#L119 

## CPU flag
http://unix.stackexchange.com/questions/43539/what-do-the-flags-in-proc-cpuinfo-mean  

## RS232 3pin
http://flykof.pixnet.net/blog/post/24074586-rs232%E7%B0%A1%E5%96%AE%E6%8E%A5%E6%B3%95(3%E7%B7%9A)

# MySQL Cluster
http://severalnines.com/blog/mysql-docker-introduction-docker-swarm-mode-and-multi-host-networking  
https://dev.mysql.com/doc/refman/5.7/en/mysql-cluster-ndb-innodb-engines.html

# Sync
https://www.resilio.com/platforms/desktop/

# Instant Notifications
http://instapush.im/

# IoT
https://www.xively.com/

# taobao
http://pt42.cn/taobaobasket_index.htm

# ANDROID
    adb push filename /sdcard/.

## miflash unlock
    fastboot oem edl
    fastboot oem edl-reboot