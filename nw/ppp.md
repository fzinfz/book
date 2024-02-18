- [L2TP](#l2tp)
    - [v3](#v3)
- [PPPoE](#pppoe)
    - [UBNT](#ubnt)

# L2TP
https://en.wikipedia.org/wiki/Layer_2_Tunneling_Protocol
- It is common to carry PPP sessions within an L2TP tunnel. 

        [mikrotik] /interface l2tp-server server set enabled=yes use-ipsec=yes

## v3
appeared as proposed standard RFC 3931 in 2005

https://en.wikipedia.org/wiki/L2TPv3
- can be regarded as being to MPLS what IP is to ATM

# PPPoE
## UBNT
/#Services/PPPoE | range in DHCP server : 192.168.11.* | DNS manually
/#Routing/Static | auto generated : 10.255.253.0/32

        [mikrotik] /interface/pppoe-client> monitor 
        numbers: 0
                status: connected
                uptime: 14m40s
            active-links: 1
                encoding: 
            service-name: 
                ac-name: EdgeRouter-X-5-Port
                ac-mac: ---
                    mtu: 1492
                    mru: 1492
        local-address: 192.168.11.100
        remote-address: 10.255.253.0
