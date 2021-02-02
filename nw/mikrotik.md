<!-- TOC -->

- [Tasks](#tasks)
- [FastPath + Conntrack = FastTrack](#fastpath--conntrack--fasttrack)
- [Sniffer & Wireshark](#sniffer--wireshark)
- [OpenVPN](#openvpn)

<!-- /TOC -->

# Tasks

    Export memory log
      /log print file=log.txt
    Port scan
      /system telnet 192.168.1.1 80
    SSH
      /user ssh-keys import public-key-file= user=
      /ip ssh print
      /ip ssh set forwarding-enabled=local

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
  tap, which is needed for bridge mode gateways. RouterOS defines this as ethernet.成都