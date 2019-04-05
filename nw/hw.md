<!-- TOC -->

- [arm/mipsel/x86 packages](#armmipselx86-packages)
- [Mikrotik](#mikrotik)
    - [Reset](#reset)
    - [Diagram](#diagram)
    - [Wireless](#wireless)
    - [CLI](#cli)
    - [PCQ](#pcq)
    - [PPP BCP](#ppp-bcp)
- [ER-X](#er-x)
    - [enable apt](#enable-apt)
    - [List dhcp/static clients](#list-dhcpstatic-clients)
    - [RIP](#rip)
    - [Firmware](#firmware)
    - [custom scripts](#custom-scripts)
- [Unifi-AC-Lite/LR](#unifi-ac-litelr)
    - [Commands](#commands)
    - [Issues](#issues)

<!-- /TOC -->

# arm/mipsel/x86 packages
http://pkg.entware.net/binaries/

    tar zxvf *.ipk
    tar zxvf data.tar.gz

# Mikrotik
TopCommon mistakes: https://www.youtube.com/watch?v=3LmQYIQ5RoA  

## Reset
https://wiki.mikrotik.com/wiki/Manual:Reset

    Hold this button before applying power, release after three seconds since powering, to load backup Boot loader.
    If you keep holding this button for 2 more seconds until LED light starts flashing, release the button to reset RouterOS configuration to default (total 5 seconds)

## Diagram
![](http://mikrotik-trainings.com/docs/MikroTik_PacketFlow_Routing.jpg)

## Wireless
RouterOS AP accepts clients in station-bridge mode when enabled using bridge-mode parameter.

default-forwarding (on AP) – gives ability to disable the communication between the wireless clients  
default-authentication – enables AP to register a client even if it is not in access list. In turn for client it allows to associate with AP not listed in client's connect list

## CLI
```
put [resolve google.com server 8.8.8.8]

/ip hotspot walled-garden
ip add dst-address=1.1.1.1 action=accept
add dst-host=:^www.bing.com path=":/*\$"
    >>> regular expression start with a colon (':')
    >>> $ requires the escape character '\' to stop it from be processed as an actual $)
```

## PCQ
https://wiki.mikrotik.com/wiki/Manual:Queue_Size  
http://mum.mikrotik.com/presentations/US08/janism.pdf  
https://wiki.mikrotik.com/wiki/Manual:HTB-Token_Bucket_Algorithm

## PPP BCP
https://wiki.mikrotik.com/wiki/Manual:BCP_bridging_(PPP_tunnel_bridging)

# ER-X
```
system type             : MT7621

processor               : 3
cpu model               : MIPS 1004Kc V2.15
BogoMIPS                : 583.68
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 32
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 4, address/irw mask: [0x0ffc, 0x0ffc, 0x0f                                                    fb, 0x0ffb]
isa                     : mips1 mips2 mips32r1 mips32r2
ASEs implemented        : mips16 dsp mt

ubnt@ubnt:~$ free -m
             total       used       free     shared    buffers     cached
Mem:           249        226         22          0         24         94
-/+ buffers/cache:        107        141
Swap:            0          0          0
```

## enable apt
https://help.ubnt.com/hc/en-us/articles/205202560-EdgeRouter-Add-other-Debian-packages-to-EdgeOS

    configure
    set system package repository wheezy components 'main contrib non-free'
    set system package repository wheezy distribution wheezy 
    set system package repository wheezy url http://http.us.debian.org/debian
    commit
    save
    exit
    sudo apt-get update
    apt-cache search supervisor

## List dhcp/static clients
https://community.ubnt.com/t5/EdgeMAX/Anyway-to-see-connected-clients-Both-DHCP-and-Static/td-p/697223  

    set service dhcp-server hostfile-update enable  
    cat /etc/hosts

## RIP
    ubnt@ubnt# show protocols rip

        interface switch0
        interface eth0
        neighbor 192.168.3.1
        redistribute {
            connected {
            }
        }

## Firmware
    show version 
    add system image http://dl.ubnt.com/...
    add system image egdeos-120821.tar
    show system image 
    reboot
    show system image storage 
    set system image default-boot 
    delete system image 

    set interfaces ethernet eth1 address 192.168.3.2/24
    commit

## custom scripts    
    chmod +x /config/scripts/post-config.d/yourscript.sh
        #!/bin/bash

# Unifi-AC-Lite/LR
https://community.ubnt.com/t5/UniFi-Updates-Blog/bg-p/Blog_UniFi

```
system type             : Qualcomm Atheros QCA956X rev 0
processor               : 0
cpu model               : MIPS 74Kc V5.0
BogoMIPS                : 385.84
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 32
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 4, ...
ASEs implemented        : mips16 dsp

BZ.v3.7.5# free -m
             total         used         free       shared      buffers
Mem:(Lite)        126316        62272        64044            0            0
-/+ buffers:              62272        64044
Mem:(LR)        126272        66764        59508            0            0
-/+ buffers:              66764        59508
Swap:            0            0            0
```

## Commands
    BZ.v3.7.5# info
    BZ.v3.7.5# set-inform http://unifi:8080/inform

## Issues
Every minor setting change on controller causes SSID reset.