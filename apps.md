<!-- TOC -->

- [.iso to USB](#iso-to-usb)
- [PXE](#pxe)
- [Screen sharing](#screen-sharing)
  - [Shell](#shell)
- [Terminal](#terminal)
  - [Windows](#windows)
- [KVM switch](#kvm-switch)
- [File Transfer](#file-transfer)
- [Note](#note)
  - [NextCloud](#nextcloud)
- [Sync](#sync)
  - [ResilioSync/BTSync](#resiliosyncbtsync)
- [GPU](#gpu)
  - [OpenCL](#opencl)
- [bench](#bench)
  - [net](#net)
- [DSM](#dsm)
- [Security](#security)
  - [Password Managment](#password-managment)
    - [Bitwarden](#bitwarden)
- [Instant Notifications](#instant-notifications)
- [IoT](#iot)
- [电商](#电商)
- [Cleaning](#cleaning)

<!-- /TOC -->

# .iso to USB
    ventoy:  copy .iso to flash drive directly
    rufus:   not support mount drive, but can add location; support WTG.
    Etcher:  may not support Windows
    https://github.com/nkc3g4/wtg-assistant  : support 16G flash drive

# PXE
https://github.com/zwj4031/netgrubfm/  
https://space.bilibili.com/14597170/video  

# Screen sharing
|Type|Site|Server|Client|Management|
|---|---|---|---|---|
|OSS|https://deskreen.com/|win/mac/linux|web|ViewOnly|
|Commercial|https://spacedesk.net/|win|win/ios/android/web|Touch|

## Shell
https://asciinema.org/

# Terminal
## Windows
C | X11/XYZModem: https://github.com/kingToolbox/WindTerm  
TypeScript | Terminus: https://github.com/Eugeny/tabby  
Free version allowd in companay: https://mobaxterm.mobatek.net/download.html   
Free for home: https://www.netsarang.com/xshell_download.html  

# KVM switch
https://github.com/debauchee/barrier/   
Barrier was forked from Symless's Synergy 1.9 codebase.

h/w: pikvm

# File Transfer
https://github.com/blueimp/jQuery-File-Upload  

# Note
## NextCloud
https://github.com/docker-library/docs/blob/master/nextcloud/README.md#using-the-apache-image

https://help.nextcloud.com/t/tutorial-how-to-migrate-mass-data-to-a-new-nextcloud-server/9418

if behind rproxy:   
https://docs.nextcloud.com/server/19/admin_manual/configuration_server/config_sample_php_parameters.html?highlight=overwrite%20cli%20url#proxy-configurations

    'overwritehost' => '...',
    'overwriteprotocol' => 'https',

# Sync
## ResilioSync/BTSync
https://www.resilio.com/platforms/desktop/
https://download-cdn.resilio.com/stable/windows64/Resilio-Sync_x64.exe  
https://download-cdn.resilio.com/stable/linux-x64/resilio-sync_x64.tar.gz  

# GPU
## OpenCL
    phoronix-test-suite benchmark pts/opencl

    phoronix-test-suite test system/opencl
    # https://download.blender.org/demo/test/cycles_benchmark_20160228.zip

# bench
## net
https://download.mikrotik.com/routeros/6.48/btest.exe

# DSM
https://xpenology.club/install-xpenology-dsm-6-1-x-proxmox/
- UEFI q35 + USB boot + SATA data disk

Ports: https://www.synology.com/en-us/knowledgebase/DSM/tutorial/Network/What_network_ports_are_used_by_Synology_services

# Security
Password Crack: https://hashcat.net/hashcat

## Password Managment
### Bitwarden
lightweight: https://github.com/dani-garcia/vaultwarden
clients/extensions: https://bitwarden.com/download/

# Instant Notifications
http://instapush.im/

# IoT
https://www.xively.com/

# 电商
京东、淘宝 订单导出： https://github.com/kangvcar/InfoSpider  
TaoBaoBasket | 同店多搜： https://pc.qq.com/detail/5/detail_18345.html  

# Cleaning
Explorer: https://github.com/1357310795/MyComputerManager