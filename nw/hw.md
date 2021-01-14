<!-- TOC -->

- [arm/mipsel/x86 packages](#armmipselx86-packages)
- [Mikrotik](#mikrotik)
    - [Quickset](#quickset)
    - [Reset](#reset)
    - [Diagram](#diagram)
    - [Wireless](#wireless)
        - [Modes](#modes)
    - [CLI](#cli)
    - [PCQ](#pcq)
    - [PPP BCP](#ppp-bcp)
- [UBNT](#ubnt)
    - [UNMS](#unms)
- [ER-X](#er-x)
    - [Reset](#reset-1)
    - [Console](#console)
    - [bootloader](#bootloader)
    - [Firmware](#firmware)
        - [OpenWRT](#openwrt)
    - [custom scripts](#custom-scripts)
    - [Web Setup Wizards](#web-setup-wizards)
        - [Switch](#switch)
    - [CLI](#cli-1)
        - [enable apt](#enable-apt)
        - [List dhcp/static clients](#list-dhcpstatic-clients)
        - [RIP](#rip)
- [Unifi-AC-Lite/LR](#unifi-ac-litelr)
    - [Controller Web](#controller-web)
- [NanoStation® M](#nanostation®-m)

<!-- /TOC -->

# arm/mipsel/x86 packages
http://pkg.entware.net/binaries/mipsel/

    tar zxvf *.ipk
    tar zxvf data.tar.gz

# Mikrotik
TopCommon mistakes: https://www.youtube.com/watch?v=3LmQYIQ5RoA  

check if winbox not working: /webfig/#IP:Services

## Quickset

    CAP: managed by a centralised CAPsMAN server

    CPE: Client device

    BasicAP: Wireless
    HomeAP: Wireless/Guest; WAN; LAN; VPN; System update/reset/password
    WISP AP: Wireless Bridge/Router;  VPN; System update/reset/password

    Home Mesh: Enables the CAPsMAN server in the router, and places the local WiFi interfaces under CAPsMAN control. Just boot other MikroTik WiFi APs with the reset button pressed.

    PTP Bridge AP: transparently interconnect two remote locations together in the same network, set one device to this mode, and the other => PTP Bridge CPE

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

### Modes
https://wiki.mikrotik.com/wiki/Manual:Wireless_Station_Modes



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

# UBNT
## UNMS
curl -fsSL https://unms.com/v1/install > /tmp/unms_inst.sh && sudo bash /tmp/unms_inst.sh

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
```

## Reset
Reset button for about 10 seconds until the eth4 LED flashing/solid. 
default: static | https://192.168.1.1 (eth0)

## Console
Pinout: https://openwrt.org/_media/media/ubiquiti/edgerouter-x-sfp2.jpg  
My TTL cables: green/red/yellow/grey | Putty: 57600 8-N-1  

https://help.ubnt.com/hc/en-us/articles/360018189493-EdgeRouter-Manual-TFTP-Recovery#3  
https://dl.ui.com/firmwares/edgemax/v2.0.x/ER-e50.recovery.v2.0.6.5208541.190708.0508.16de5fdde.img (>100M)  

    The baud rate for ER-X / ER-X-SFP / ER-10X and EP-R6 console connections is 57600 instead of 115200.
    Hold down the 1 (number one) key as the router starts up

    1: System Load Linux to SDRAM via TFTP.
    Please Input new ones /or Ctrl-C to discard
            Input device IP (172.16.3.212) ==:192.168.1.20
            Input server IP (172.16.3.210) ==:192.168.1.10
            Input Linux Kernel filename (vme50) ==:ER-e50.recovery.v2.0.6.5208541.190708.0508.16de5fdde.img
        
## bootloader
https://help.ubnt.com/hc/en-us/articles/360009932554-EdgeRouter-How-to-Update-the-Bootloader

    show system boot-image
    add system boot-image

## Firmware
https://www.ui.com/download/edgemax/edgerouter-x

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

### OpenWRT
https://openwrt.org/toh/ubiquiti/ubiquiti_edgerouter_x_er-x_ka

## custom scripts    
    chmod +x /config/scripts/post-config.d/yourscript.sh
        #!/bin/bash

## Web Setup Wizards
### Switch

     switch switch0 {
         address dhcp
         switch-port {
             interface eth0 {
             }
             interface eth1 {
             }
             interface eth2 {
             }
             interface eth3 {
             }
             interface eth4 {
             }
         }
     }

## CLI

    ubnt@ubnt:~$ configure
    [edit]
    ubnt@ubnt# show
    
### enable apt
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
    
### List dhcp/static clients
https://community.ubnt.com/t5/EdgeMAX/Anyway-to-see-connected-clients-Both-DHCP-and-Static/td-p/697223  

    set service dhcp-server hostfile-update enable  
    cat /etc/hosts
    
### RIP
    ubnt@ubnt# show protocols rip

        interface switch0
        interface eth0
        neighbor 192.168.3.1
        redistribute {
            connected {
            }
        }

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

BZ.v3.7.5# info
BZ.v3.7.5# set-inform http://unifi:8080/inform
```

## Controller Web

    Settings - Sie DEVICE AUTHENTICATION
    Every minor setting change on controller causes SSID reset.

# NanoStation® M
https://www.ui.com/download/airmax-m/nanostationm
