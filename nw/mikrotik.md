<!-- TOC -->

- [CHR 60-day trial](#chr-60-day-trial)
- [IPv6](#ipv6)
- [Performance](#performance)
- [Tasks](#tasks)
    - [Quickset](#quickset)
        - [CPE](#cpe)
    - [Wireless](#wireless)
    - [Reset](#reset)
    - [PCQ](#pcq)
    - [hotspot](#hotspot)
- [Routing](#routing)
    - [Packet Flow](#packet-flow)
- [Models](#models)
- [Switch Chip](#switch-chip)
    - [Switch VLAN](#switch-vlan)
- [Bridge VLAN](#bridge-vlan)
- [FastPath + Conntrack = FastTrack](#fastpath--conntrack--fasttrack)
- [Sniffer and Wireshark](#sniffer-and-wireshark)
- [VPN](#vpn)
    - [OpenVPN](#openvpn)
    - [WireGuard](#wireguard)
    - [PPP BCP](#ppp-bcp)
- [mwan](#mwan)
    - [Bandwidth based - Mangle + scripting](#bandwidth-based---mangle--scripting)
    - [PCC - diff subnet/bandwidth](#pcc---diff-subnetbandwidth)
- [WAN + ppp](#wan--ppp)
- [Videos](#videos)
- [Automation](#automation)
    - [Scripting](#scripting)
    - [SSH](#ssh)
    - [API](#api)
        - [Python](#python)
- [Monitoring](#monitoring)
    - [Grafana & Prometheus](#grafana--prometheus)
- [Manage Remote](#manage-remote)

<!-- /TOC -->

# CHR 60-day trial
https://mikrotik.com/client/chr  
https://wiki.mikrotik.com/wiki/Manual:CHR#60-day_trial

    /system license renew 
    level: p1

# IPv6
Server: only delegate IPv6 prefixes, not addresses: https://wiki.mikrotik.com/wiki/Manual:IPv6/DHCP_Server

    # Client
    /ipv6 dhcp-client
    add add-default-route=yes interface=ether5 pool-name=pub-pool-1 request=prefix
    /ipv6 address
    add address=... eui-64=yes from-pool=pub-pool-1 interface=ether5

# Performance
Hardware offloading([Chip](#switch-chip)) > [Fast Forward(CPU)](https://wiki.mikrotik.com/wiki/Manual:Interface/Bridge#Fast_Forward) > [Fast Path](https://wiki.mikrotik.com/wiki/Manual:Fast_Path) > Slow Path

    /interface bridge settings print

# Tasks

    DDNS
      /ip cloud set ddns-enabled=yes
    Export memory log
      /log print file=log.txt
    Port scan
      /system telnet 192.168.1.1 80
    Check link speed
     /interface ethernet monitor
    SSH
      /user ssh-keys import public-key-file= user=
      /ip ssh print
      /ip ssh set forwarding-enabled=local

- if winbox not working: `/webfig/#IP:Services`

- create/dump/unpack .npk: https://github.com/kost/mikrotik-npk  
- vulnerabilities: https://github.com/microsoft/routeros-scanner  
- Monitor/control from Home Assistant: https://github.com/tomaae/homeassistant-mikrotik_router

## Quickset

- CPE: Client device
- BasicAP: Wireless
- HomeAP: Wireless/Guest; WAN; LAN; VPN; System update/reset/password
- Wireless ISP (WISP) AP: 802.11/nstreme/nv2 Wireless Bridge/Router;  VPN; System update/reset/password
- Home Mesh: Enables the CAPsMAN server in the router, and places the local WiFi interfaces under CAPsMAN control. Just boot other MikroTik WiFi APs with the reset button pressed.
  - not adding self => Wireless -> CAP: CAPsMAN addr add "127.0.0.1"
  - "No supported channel" => reset with default config and run quickset first
- PTP Bridge AP: transparently interconnect two remote locations together in the same network, set one device to this mode, and the other => PTP Bridge CPE

### CPE
https://wiki.mikrotik.com/wiki/Manual:Wireless_Station_Modes#Mode_station-pseudobridge

802.11
- station: if L2 bridging on station is not necessary - as in case of routed or MPLS switched network
- station-pseudobridge : single MAC address translation
- station-pseudobridge-clone : either address configured or first forwarded frame

        /interface wireless
        set [ find default-name=wlan1 ] disabled=no mode=station-pseudobridge ssid=Soyo_22MAR8287
        /interface wireless security-profiles
        set [ find default=yes ] authentication-types=wpa-psk,wpa2-psk group-ciphers=tkip,aes-ccm mode=dynamic-keys supplicant-identity=MikroTik unicast-ciphers=tkip,aes-ccm wpa-pre-shared-key=88888888 wpa2-pre-shared-key=88888888

## Wireless
RouterOS AP accepts clients in station-bridge mode when enabled using bridge-mode parameter.

default-forwarding (on AP) – gives ability to disable the communication between the wireless clients  
default-authentication – enables AP to register a client even if it is not in access list. In turn for client it allows to associate with AP not listed in client's connect list

## Reset
https://wiki.mikrotik.com/wiki/Manual:Reset

    Hold this button before applying power, release after three seconds since powering, to load backup Boot loader.
    If you keep holding this button for 2 more seconds until LED light starts flashing, release the button to reset RouterOS configuration to default (total 5 seconds)

## PCQ
https://wiki.mikrotik.com/wiki/Manual:Queue_Size  
http://mum.mikrotik.com/presentations/US08/janism.pdf  
https://wiki.mikrotik.com/wiki/Manual:HTB-Token_Bucket_Algorithm

## hotspot

    /ip hotspot walled-garden
    ip add dst-address=1.1.1.1 action=accept
    add dst-host=:^www.bing.com path=":/*\$"
        >>> regular expression start with a colon (':')
        >>> $ requires the escape character '\' to stop it from be processed as an actual $)

# Routing
## Packet Flow
![](https://i.imgur.com/Mo8DgjH.png)

# Models
|Model|Alias|Arch|Dude|Chip|CPU|MHz|RAM|Storage|Ports|PoE In|Out|Mbit/s|dBi|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|[RB750Gr3](https://mikrotik.com/product/RB750Gr3)|hEX|MMIPS|v6/7|MT7621A|2C4T|880|256|16/TF/USB|5/1G|8-30 V|N/A|N/A||
|[RB941-2nD](https://mikrotik.com/product/RB941-2nD)|hAP lite|SMIPS|-|QCA9533|1C|650|32|16|4/100|MicroUSB|N/A|300|1.5|
|[RB951G-2HnD](https://mikrotik.com/product/RB951G-2HnD)||MIPSBE|-|AR9344|1C|600|128|128|5/1G|8-30 V|N/A|300|2.5|
|[RBD52G-*](https://mikrotik.com/product/hap_ac2)|hAP ac²|ARM32|v6/7|IPQ-4018|4|716|128|16/USB|5/1G|18-28 V|N/A|300/867|2.5/2.5|

# Switch Chip
https://wiki.mikrotik.com/wiki/Manual:Switch_Chip_Features

|Model|RB3011 |RB951G|RB750G|RB951Ui-2HnD|RB951-2n|RB750Gr3|
|---|---|---|---|---|---|---|
|Feature|QCA8337|Atheros8327|Atheros8316|Atheros8227|Atheros7240|MT7621|
|Port Switching|yes|yes|yes|yes|yes|yes|
|Port Mirroring|yes|yes|yes|yes|yes|yes|
|TX limit|yes|yes|yes|yes|yes|no|
|RX limit|yes|yes|no|no|no|no|
|Vlan table|4096 entries|4096 entries|4096 entries|4096 entries|16 entries|no|
|Rule table|92 rules|92 rules|32 rules|no|no|no|

## Switch VLAN

- vlan-mode # QCA8337(RB3011) and Atheros8327(RB951G-2HnD): when vlan-mode=secure is used, it ignores switch port vlan-header options.
  - fallback 
    - check ingress
      - If ingress traffic is tagged and egress port is not found in the VLAN table for the appropriate VLAN ID, then traffic is dropped.
    - forwards all untagged traffic. If a VLAN ID is not found in the VLAN Table, then traffic is forwarded. Used to allow known VLANs only in specific ports.
  - check 
    - check ingress, drops all untagged traffic. 
      - If ingress traffic is tagged and egress port is not found in the VLAN table for the appropriate VLAN ID, then traffic is dropped.
  - secure 
    - check ingress, drops all untagged traffic. Both ingress and egress port must be found in the VLAN Table for the appropriate VLAN ID, otherwise traffic is dropped.

- vlan-header
  - =leave-as-is default
  - =always-strip for access ports
  - =add-if-missing for trunk port 

# Bridge VLAN
- way 1: add br-vlan: if-vlan + phy-access-port
- way 2: set filtering: https://wiki.mikrotik.com/wiki/Manual:Interface/Bridge#Bridge_VLAN_Filtering

# FastPath + Conntrack = FastTrack
- https://mum.mikrotik.com/presentations/UA15/presentation_3077_1449654925.pdf
- https://mum.mikrotik.com/presentations/TR18/presentation_5628_1539936230.pdf

- https://wiki.mikrotik.com/wiki/Manual:Fast_Path
- https://wiki.mikrotik.com/wiki/Manual:IP/Fasttrack

# Sniffer and Wireshark
https://mum.mikrotik.com/presentations/ID19/presentation_6708_1572241150.pdf

    /tool sniffer print # running: yes/no
    # wireshark capture filter: udp port 37008
    /tool sniffer streaming-server=ip.of.wireshark.box => click Start!

    /interface ethernet switch set switch1 mirror-source=

# VPN
## OpenVPN
https://wiki.mikrotik.com/wiki/OpenVPN

  tun, RouterOS defines this as ip.
  tap, which is needed for bridge mode gateways. RouterOS defines this as ethernet.

## WireGuard
Both WAN: https://help.mikrotik.com/docs/display/ROS/WireGuard  
1 Server: https://forum.mikrotik.com/viewtopic.php?t=174417

## PPP BCP
https://wiki.mikrotik.com/wiki/Manual:BCP_bridging_(PPP_tunnel_bridging)

# mwan
Bandwidth-based load-balancing with failover: https://mum.mikrotik.com/presentations/US12/tomas.pdf  

  Bonding: - You need to control of both ends of the link
  Policy routing: - Not dynamic / Scalability problems
  PCC: - Not bandwidth wise
  Bandwidth based: + scalable | MPLS TE / Mangle + scripting

## Bandwidth based - Mangle + scripting
Steps: from page 23

## PCC - diff subnet/bandwidth
https://mum.mikrotik.com/presentations/US12/steve.pdf
mark connections -> associate routing marks with packets -> Create routes
- p81: action=accept chain=prerouting dst-address=172.*.0.0/24
- p91: action=mark-connection chain=prerouting connection-mark=no-mark in-interface=LAN new-connection-mark=WAN1 passthrough=yes per-connection-classifier=
- p100a: action=mark-routing chain=prerouting connection-mark=WAN1 new-routing-mark=WAN1-mark passthrough=yes
- p100b: action=mark-routing chain=output connection-mark=WAN1 new-routing-mark=WAN1-mark passthrough=yes
- p104: action=mark-connection chain=prerouting connection-mark=no-mark in-interface=WAN1 new-connection-mark=WAN1 passthrough=yes

https://aacable.wordpress.com/2011/07/27/mikrotik-dual-wan-load-balancing-using-pcc-method-complete-script-by-zaib/

# WAN + ppp

    /ip firewall nat add action=masquerade chain=srcnat out-interface=l2tp-out1
    /ip route add dst-address=192.168.1.0/24 gateway=192.168.89.1 ...

# Videos
TopCommon mistakes: https://www.youtube.com/watch?v=3LmQYIQ5RoA  

# Automation

Web Helper | need SignUp: https://github.com/buananetpbun/buananetpbun.github.io | https://buananetpbun.github.io/
## Scripting
https://wiki.mikrotik.com/wiki/Manual:Scripting

    :put [resolve google.com server 8.8.8.8] # put=print

https://github.com/eworm-de/routeros-scripts  

## SSH
https://help.mikrotik.com/docs/display/ROS/SSH

## API
- https://help.mikrotik.com/docs/display/ROS/API#API-Exampleclient

### Python
- https://github.com/LaiArturs/RouterOS_API
- https://librouteros.readthedocs.io/en/latest/query.html  

# Monitoring
## Grafana & Prometheus
- Py + Dockerfile : https://github.com/akpw/mktxp
  - Grafana | docker-compose : https://github.com/akpw/mktxp-stack
  - Grafana | RouterOS v7 + Raspi: https://github.com/M0r13n/mikrotik_monitoring

    docker exec -it mktxp /bin/sh
        mktxp show  # cat /root/mktxp/mktxp.conf
        mktxp print -en 'Sample-Router' -cc # test connection & show CAPsMAN clients

- Go + Dockerfile: https://github.com/nshttpd/mikrotik-exporter
  - Grafana | k8s: https://www.lisenet.com/2021/monitor-mikrotik-router-with-grafana-and-prometheus-mikrotik-exporter/

# Manage Remote
ROS v7: conf socks4 and route

    /ip route add dst-address=192.168.1.1/24 gateway=l2tp-out1
    /ip socks set enabled=yes

[/nw/proxy/#host-apps](/nw/proxy/#host-apps)
    