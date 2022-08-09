<!-- TOC -->

- [Tasks](#tasks)
    - [Scripting](#scripting)
    - [Quickset](#quickset)
    - [Reset](#reset)
    - [PCQ](#pcq)
    - [hotspot](#hotspot)
- [Routing](#routing)
    - [Packet Flow](#packet-flow)
- [Wireless](#wireless)
    - [Modes](#modes)
- [Switch Chip](#switch-chip)
- [FastPath + Conntrack = FastTrack](#fastpath--conntrack--fasttrack)
- [Sniffer & Wireshark](#sniffer--wireshark)
- [VPN](#vpn)
    - [OpenVPN](#openvpn)
    - [WireGuard](#wireguard)
    - [PPP BCP](#ppp-bcp)
- [Videos](#videos)

<!-- /TOC -->

# Tasks

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
       
check if winbox not working: /webfig/#IP:Services

## Scripting
https://wiki.mikrotik.com/wiki/Manual:Scripting

  :put [resolve google.com server 8.8.8.8] # put=print

## Quickset

    CAP: managed by a centralised CAPsMAN server

    CPE: Client device

    BasicAP: Wireless
    HomeAP: Wireless/Guest; WAN; LAN; VPN; System update/reset/password
    Wireless ISP (WISP) AP: 802.11/nstreme/nv2 Wireless Bridge/Router;  VPN; System update/reset/password

    Home Mesh: Enables the CAPsMAN server in the router, and places the local WiFi interfaces under CAPsMAN control. Just boot other MikroTik WiFi APs with the reset button pressed.

not adding self => Wireless -> CAP: CAPsMAN addr add "127.0.0.1"
"No supported channel" => reset and run quickset first

    PTP Bridge AP: transparently interconnect two remote locations together in the same network, set one device to this mode, and the other => PTP Bridge CPE

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

# Wireless
RouterOS AP accepts clients in station-bridge mode when enabled using bridge-mode parameter.

default-forwarding (on AP) – gives ability to disable the communication between the wireless clients  
default-authentication – enables AP to register a client even if it is not in access list. In turn for client it allows to associate with AP not listed in client's connect list

## Modes
https://wiki.mikrotik.com/wiki/Manual:Wireless_Station_Modes

# Switch Chip
|Model|RB3011 |RB951G|RB750G|RB951Ui-2HnD|RB951-2n|RB750Gr3|
|---|---|---|---|---|---|---|
|Feature|QCA8337|Atheros8327|Atheros8316|Atheros8227|Atheros7240|MT7621|
|Port Switching|yes|yes|yes|yes|yes|yes|
|Port Mirroring|yes|yes|yes|yes|yes|yes|
|TX limit|yes|yes|yes|yes|yes|no|
|RX limit|yes|yes|no|no|no|no|
|Host table|2048 entries|2048 entries|2048 entries|1024 entries|2048 entries|2048 entries|
|Vlan table|4096 entries|4096 entries|4096 entries|4096 entries|16 entries|no|
|Rule table|92 rules|92 rules|32 rules|no|no|no|

# FastPath + Conntrack = FastTrack
- https://mum.mikrotik.com/presentations/UA15/presentation_3077_1449654925.pdf
- https://mum.mikrotik.com/presentations/TR18/presentation_5628_1539936230.pdf

- https://wiki.mikrotik.com/wiki/Manual:Fast_Path
- https://wiki.mikrotik.com/wiki/Manual:IP/Fasttrack

# Sniffer & Wireshark
https://mum.mikrotik.com/presentations/ID19/presentation_6708_1572241150.pdf

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

# Videos
TopCommon mistakes: https://www.youtube.com/watch?v=3LmQYIQ5RoA  