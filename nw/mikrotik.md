<!-- TOC -->

- [Tasks](#tasks)
- [Switch Chip](#switch-chip)
- [FastPath + Conntrack = FastTrack](#fastpath--conntrack--fasttrack)
- [Sniffer & Wireshark](#sniffer--wireshark)
- [OpenVPN](#openvpn)

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

# OpenVPN
https://wiki.mikrotik.com/wiki/OpenVPN

  tun, RouterOS defines this as ip.
  tap, which is needed for bridge mode gateways. RouterOS defines this as ethernet.