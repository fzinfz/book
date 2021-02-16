<!-- TOC -->

- [Screen sharing](#screen-sharing)
- [KVM switch](#kvm-switch)
- [Chrome](#chrome)
- [nano](#nano)
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
- [Instant Notifications](#instant-notifications)
- [IoT](#iot)
- [Taobao](#taobao)

<!-- /TOC -->

# Screen sharing
|Type|Site|Server|Client|Management|
|---|---|---|---|---|
|OSS|https://spacedesk.net/|win|win/ios/android/web|ViewOnly|
|Commercial|https://deskreen.com/|win/mac/linux|web|Touch|

# KVM switch
https://github.com/debauchee/barrier/   
Barrier was forked from Symless's Synergy 1.9 codebase.

# Chrome
F12 -> Ctrl+Shift+P -> "screenshot"
Address: Shift + Del

# nano
CTRL + Shift + 6:   mark
CTRL + K:           cut/delete

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

# Instant Notifications
http://instapush.im/

# IoT
https://www.xively.com/

# Taobao
http://pt42.cn/taobaobasket_index.htm
