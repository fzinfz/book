<!-- TOC -->

- [GUI tool](#gui-tool)
- [Basic](#basic)
    - [Port listening](#port-listening)
    - [debug](#debug)
    - [Netlink](#netlink)
    - [tuntap](#tuntap)
    - [Features](#features)
    - [disable ipv6](#disable-ipv6)
- [iptables](#iptables)
    - [table / chain](#table--chain)
    - [rules](#rules)
    - [NAT](#nat)
    - [Trace](#trace)
    - [Log manually](#log-manually)
    - [Transparent Proxy](#transparent-proxy)
- [iptables frontend](#iptables-frontend)
    - [CentOS firewall-cmd](#centos-firewall-cmd)
    - [Ubuntu - ufw](#ubuntu---ufw)
- [ip rule](#ip-rule)
- [tc](#tc)
- [LVS](#lvs)
- [Virtual routing and forwarding](#virtual-routing-and-forwarding)
- [DNS](#dns)

<!-- /TOC -->

# GUI tool

    nm-connection-editor
    /etc/init.d/network-manager restart

# Basic
https://access.redhat.com/sites/default/files/attachments/rh_ip_command_cheatsheet_1214_jcs_print.pdf

    ls -l /sys/class/net/   # E.g.: ens3 -> ../../devices/pci0000:00/0000:00:03.0/virtio0/net/ens3
    ip addr show dev eth1

    ifconfig ens7 10.99.0.10/16 up
    ip addr add 192.168.6.13/24 dev eth0 && ip link set eth0 up

    ip addr flush dev eth0
    ifconfig eth0 0.0.0.0 0.0.0.0 && dhclient

    ip route add default via 192.168.1.1
    ip route show table all

## Port listening
   
    # netstat -lntup | grep 8888
    tcp        0      0 0.0.0.0:8888            0.0.0.0:*               LISTEN      5119/python         
    tcp6       0      0 :::8888                 :::*                    LISTEN      5119/python     

    # ss -lntup | grep 8888
    tcp   LISTEN  0       128                    0.0.0.0:8888         0.0.0.0:*      users:(("jupyter-noteboo",pid=5119,fd=7))                                      
    tcp   LISTEN  0       128                       [::]:8888            [::]:*      users:(("jupyter-noteboo",pid=5119,fd=6))       

## debug
    tcpdump -i any port 27017
    nmap -sV -p6379 127.0.0.1

## Netlink
https://en.wikipedia.org/wiki/Netlink

https://github.com/shemminger/iproute2/blob/master/misc/ss.c

## tuntap
    ip tuntap add mode tap dev tap1
            tap1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
            link/ether a2:05:e8:7f:d9:e8 brd ff:ff:ff:ff:ff:ff

    ip tuntap add mode tun dev tun1
            tun1: <POINTOPOINT,MULTICAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 500
            link/none

## Features
    ethtool -k ens3 | grep offload              # list Features
    ethtool -K ens3 gro off gso off tso off     # set tcp-segmentation-offload, generic-segmentation/receive-offload

## disable ipv6
    echo "net.ipv6.conf.all.disable_ipv6=1"  >> /etc/sysctl.conf
    sysctl  -p

# iptables
## table / chain
    iptables -t nat -L # filter(default), nat, mangle, raw and security
    iptables -t nat -F ...  # empty chain rules
    iptables -t nat -X ...  # delete empty chain

    iptables -t nat -L -n -x -v # --numeric IP/Port --exact packet and byte counters --verbose
    iptables -L --line-numbers
    iptables -D INPUT 2

    iptables-save

## rules
    iptables -I INPUT -i docker0 -j ACCEPT
    iptables -I INPUT -s localhost -j ACCEPT

    iptables -A INPUT --dport 81 -j DROP
    iptables -A INPUT -p tcp -m multiport  --dport 3306,6379 -j DROP
    iptables -A INPUT -p udp --dport 161 -j ACCEPT

## NAT
http://www.netfilter.org/documentation/HOWTO//NAT-HOWTO-3.html

        _____                                     _____
        /     \                                   /     \
    PREROUTING -->[Routing ]----------------->POSTROUTING----->
        \D-NAT/     [Decision]                    \S-NAT/
                        |                            ^
                        |                            |
                        --------> Local Process ------

Masquerading is a specialized form of SNAT  
Port forwarding, load sharing, and transparent proxying are all forms of DNAT.

http://www.netfilter.org/documentation/HOWTO//NAT-HOWTO-6.html  
http://ipset.netfilter.org/iptables-extensions.man.html

## Trace
http://backreference.org/2010/06/11/iptables-debugging/

    modprobe nf_log_ipv4
    sysctl net.netfilter.nf_log.2=nf_log_ipv4
    iptables -t raw -A OUTPUT -p icmp -j TRACE
    iptables -t raw -A PREROUTING -p icmp -j TRACE
    vi /var/log/kern.log

## Log manually
http://www.microhowto.info/troubleshooting/troubleshooting_iptables.html

    iptables_log_INPUT_DROP() {
        iptables -N LOGGING
        iptables -A INPUT -j LOGGING
        iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
        iptables -A LOGGING -j DROP
    }

## Transparent Proxy

    iptables -t nat -N TP
    iptables -t nat -I TP -p tcp --dport 4433 -j RETURN  # bypass Port

    # https://tools.ietf.org/html/rfc5735#page-6
    iptables -t nat -A TP -d 0.0.0.0/8 -j RETURN
    iptables -t nat -A TP -d 10.0.0.0/8 -j RETURN
    iptables -t nat -A TP -d 127.0.0.0/8 -j RETURN
    iptables -t nat -A TP -d 169.254.0.0/16 -j RETURN
    iptables -t nat -A TP -d 172.16.0.0/12 -j RETURN
    iptables -t nat -A TP -d 192.168.0.0/16 -j RETURN
    iptables -t nat -A TP -d 224.0.0.0/4 -j RETURN
    iptables -t nat -A TP -d 240.0.0.0/4 -j RETURN

    # Anything else should be redirected to Dokodemo-door's local port
    iptables -t nat -A TP -p tcp -j REDIRECT --to-ports 20088
    iptables -t nat -I OUTPUT -p tcp -j TP
    iptables -t nat -I PREROUTING -p tcp -j TP

    # Add any UDP rules
    iptables -t mangle -N TP
    iptables -t mangle -A TP -p udp --dport 53 -j TPROXY --on-port 20088 --tproxy-mark 0x01/0x01
    iptables -t mangle -A PREROUTING -j TP

    iptables -t mangle -N TP_MARK
    iptables -t mangle -A TP_MARK -p udp --dport 53 -j MARK --set-mark 1
    iptables -t mangle -A OUTPUT -j TP_MARK

    ip route add local default dev lo table 100
    ip rule add fwmark 1 lookup 100

    ip rule del fwmark 1 lookup 100 # disable UDP

# iptables frontend
## CentOS firewall-cmd
```
firewall-cmd --permanent --zone=public \
--add-rich-rule="rule family="ipv4" \
source address="1.2.3.4/32" \
port protocol="tcp" port="4567" accept"

firewall-cmd --zone=public --add-port=4433/tcp --permanent
firewall-cmd --zone=public --add-port=4433/udp--permanent
firewall-cmd --reload
firewall-cmd --list-all

service firewalld stop 
```

## Ubuntu - ufw
```
sudo ufw allow 11200:11299/tcp
sudo ufw status verbose
sudo ufw disable
```

# ip rule
    Priority: 0, Selector: match anything, Action: lookup routing
            table local (ID 255).  The local table is a special routing
            table containing high priority control routes for local and
            broadcast addresses.

    Priority: 32766, Selector: match anything, Action: lookup
            routing table main (ID 254).  The main table is the normal
            routing table containing all non-policy routes. This rule may
            be deleted and/or overridden with other ones by the
            administrator.

    Priority: 32767, Selector: match anything, Action: lookup
            routing table default (ID 253).  The default table is empty.
            It is reserved for some post-processing if no previous default
            rules selected the packet.  This rule may also be deleted.

    # cat /etc/iproute2/rt_tables

        #
        # reserved values
        #
        255	local
        254	main
        253	default
        0	unspec
        #
        # local
        #
        #1	inr.ruhep


# tc
http://events.linuxfoundation.org/sites/events/files/slides/Linux_traffic_control.pdf  

# LVS
http://kb.linuxvirtualserver.org/wiki/IPVS  
https://github.com/torvalds/linux/tree/master/net/netfilter/ipvs   
IPVS - an advanced layer-4 load balancing solution， NAT/Direct Routing/IP Tunneling

# Virtual routing and forwarding
https://docs.cumulusnetworks.com/display/DOCS/Virtual+Routing+and+Forwarding+-+VRF  
multiple independent routing tables working simultaneously on the same router or switch
Think of this feature as VLAN for layer 3

https://www.kernel.org/doc/Documentation/networking/vrf.txt

# DNS
    /etc/nsswitch.conf
        #hosts:          files mdns4_minimal [NOTFOUND=return] dns mdns4
        hosts:          files dns  # fix nslookup works but ping not work