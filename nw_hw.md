<!-- TOC -->

- [Mikrotik](#mikrotik)
    - [Diagram](#diagram)
    - [CLI](#cli)
    - [PCQ](#pcq)
    - [PPP BCP](#ppp-bcp)
- [ER-X](#er-x)
    - [List dhcp/static clients](#list-dhcpstatic-clients)
    - [RIP](#rip)
    - [Firmware](#firmware)
- [Unifi-AC-Lite](#unifi-ac-lite)
    - [Commands](#commands)

<!-- /TOC -->

# Mikrotik
## Diagram
![](http://mikrotik-trainings.com/docs/MikroTik_PacketFlow_Routing.jpg)

## CLI
    put [resolve google.com server 8.8.8.8]

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

# Unifi-AC-Lite
```
system type             : Qualcomm Atheros QCA956X rev 0

processor               : 0
cpu model               : MIPS 74Kc V5.0
BogoMIPS                : 385.84
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 32
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 4, address/irw mask: [0x0000, 0x01e8, 0x0058, 0x0048]
ASEs implemented        : mips16 dsp

BZ.v3.7.5# free -m
             total         used         free       shared      buffers
Mem:        126316        62272        64044            0            0
-/+ buffers:              62272        64044
Swap:            0            0            0
```

## Commands
    BZ.v3.7.5# info
    BZ.v3.7.5# set-inform http://unifi-controller:8080/inform