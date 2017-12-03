<!-- TOC -->

- [Basic](#basic)
    - [debug](#debug)
    - [tuntap](#tuntap)
    - [Features](#features)
    - [disable ipv6](#disable-ipv6)
- [systemd-networkd.service](#systemd-networkdservice)
- [systemd.netdev](#systemdnetdev)
    - [Kind](#kind)
    - [Examples](#examples)
        - [bridge.netdev](#bridgenetdev)
        - [dummy.netdev](#dummynetdev)
        - [vlan1.netdev](#vlan1netdev)
        - [macvtap.netdev](#macvtapnetdev)
- [systemd.network](#systemdnetwork)
    - [static.network](#staticnetwork)
    - [dhcp.network](#dhcpnetwork)
    - [A bridge with two enslaved links](#a-bridge-with-two-enslaved-links)
    - [bridge-slave-interface-vlan.network](#bridge-slave-interface-vlannetwork)
    - [macvtap.network](#macvtapnetwork)
- [systemd.link](#systemdlink)
- [iptables](#iptables)
    - [table / chain](#table--chain)
    - [rules](#rules)
    - [NAT](#nat)
    - [Trace](#trace)
    - [Log manually](#log-manually)
    - [Transparent Proxy - jump to `networking` page.](#transparent-proxy---jump-to-networking-page)
- [iptables frontend](#iptables-frontend)
    - [CentOS firewall-cmd](#centos-firewall-cmd)
    - [Ubuntu - ufw](#ubuntu---ufw)
- [ip rule](#ip-rule)
- [tc](#tc)
- [LVS](#lvs)
- [Virtual routing and forwarding](#virtual-routing-and-forwarding)
- [DNS](#dns)

<!-- /TOC -->

# Basic
https://access.redhat.com/sites/default/files/attachments/rh_ip_command_cheatsheet_1214_jcs_print.pdf

    ls -l /sys/class/net/   # E.g.: ens3 -> ../../devices/pci0000:00/0000:00:03.0/virtio0/net/ens3
    ip addr show dev eth1

    ifconfig ens7 10.99.0.10/16 up
    ip addr add 192.168.6.13/24 dev eth0 && ip link set eth0 up

    ip addr flush dev eth0
    ifconfig eth0 0.0.0.0 0.0.0.0 && dhclient

    ip route add default via 192.168.1.1

## debug
    tcpdump -i any port 27017
    nmap -sV -p6379 127.0.0.1

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

# systemd-networkd.service
/usr/lib/systemd/systemd-networkd  
https://wiki.archlinux.org/index.php/systemd-networkd  
https://www.freedesktop.org/software/systemd/man/systemd.netdev.html#

```
systemctl status systemd-networkd.service
systemctl restart systemd-networkd.service

# networkctl list
IDX LINK             TYPE               OPERATIONAL SETUP     
  1 lo               loopback           carrier     unmanaged 
  2 enp3s0           ether              no-carrier  unmanaged 
  3 eno1             ether              degraded    unmanaged 
  4 eno2             ether              degraded    configured
  7 docker0          ether              routable    unmanaged 
  9 vethec09cbe      ether              degraded    unmanaged 
 11 veth5185e04      ether              degraded    unmanaged 
 12 zt0              ether              routable    unmanaged 
 13 br0              ether              routable    configured
 14 macvtap0         ether              degraded    unmanaged 
 15 vnet0            ether              degraded    unmanaged 
 16 br8              ether              off         unmanaged 
 18 macvtap1         ether              degraded    unmanaged 
 19 vnet1            ether              degraded    unmanaged 
```

# systemd.netdev
    ls /etc/systemd/network     # local administration network directory
    ls /usr/lib/systemd/network # system network directory
    ls /run/systemd/network     # volatile runtime network directory
    `/run` is temporary and `/usr/lib` is for vendors
    symlink with the same name pointing to `/dev/null` disables the configuration file entirely

## Kind
    `bridge`	A bridge device is a software switch, and each of its slave devices and the bridge itself are ports of the switch.
    `tap`	A persistent Level 2 tunnel between a network device and a device node.
    `tun`	A persistent Level 3 tunnel between a network device and a device node.
    `veth`	An Ethernet tunnel between a pair of network devices.
    `sit`	An IPv6 over IPv4 tunnel.
    `vti`	An IPv4 over IPSec tunnel.

## Examples
### bridge.netdev
    [NetDev]
    Name=bridge0
    Kind=bridge

    [Match]
    Virtualization=no

### dummy.netdev
    [NetDev]
    Name=dummy-test
    Kind=dummy
    MACAddress=12:34:56:78:9a:bc

### vlan1.netdev
    [NetDev]
    Name=vlan1
    Kind=vlan

    [VLAN]
    Id=1

### macvtap.netdev 
    [NetDev]
    Name=macvtap-test
    Kind=macvtap

Compare with macvtap.network below.

# systemd.network
https://www.freedesktop.org/software/systemd/man/systemd.network.html

## static.network
    [Match]
    Name=enp2s0

    [Network]
    Address=192.168.0.15/24
    Gateway=192.168.0.1

## dhcp.network
    [Match]
    Name=en*

    [Network]
    DHCP=yes

## A bridge with two enslaved links
    # /etc/systemd/network/25-bridge-static.network
    [Match]
    Name=bridge0

    [Network]
    ...

    # /etc/systemd/network/25-bridge-slave-interface-1.network
    [Match]
    Name=enp2s0

    [Network]
    Bridge=bridge0

    # /etc/systemd/network/25-bridge-slave-interface-x.network 

## bridge-slave-interface-vlan.network
    [Match]
    Name=enp2s0

    [Network]
    Bridge=bridge0

    [BridgeVLAN]
    VLAN=1-32
    PVID=42
    EgressUntagged=42

    [BridgeVLAN]
    VLAN=100-200

    [BridgeVLAN]
    EgressUntagged=300-400

    VLAN=
    The VLAN ID allowed on the port. 

    EgressUntagged=
    The VLAN ID specified here will be used to untag frames on egress. 
    Configuring EgressUntagged= implicates the use of VLAN= above and will enable the VLAN ID for ingress as well. 

    PVID=
    The Port VLAN ID specified here is assigned to all untagged frames at ingress. PVID= can be used only once. 
    Configuring PVID= implicates the use of VLAN= above and will enable the VLAN ID for ingress as well.

## macvtap.network
    [Match]
    Name=enp0s25

    [Network]
    MACVTAP=macvtap-test

# systemd.link
Network link configuration is performed by the net_setup_link udev builtin.  
udev (userspace /dev) is a device manager for the Linux kernel. As the successor of devfsd and hotplug, udev primarily manages device nodes in the /dev directory.

# iptables
## table / chain
    iptables -t nat -L # filter(default), nat, mangle, raw and security
    iptables -t nat -F SHADOWSOCKS  # empty chain rules
    iptables -t nat -X SHADOWSOCKS  # delete empty chain

    iptables -t nat -L -n -v -x
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

## Transparent Proxy - jump to `networking` page.

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
    # ip rule show
    0:	from all lookup local 
    32766:	from all lookup main 
    32767:	from all lookup default

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