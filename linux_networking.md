<!-- TOC -->

- [Common](#common)
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
- [Firewall](#firewall)
    - [iptables](#iptables)
    - [CentOS](#centos)
    - [Ubuntu 16](#ubuntu-16)

<!-- /TOC -->

# Common
```
ls -l /sys/class/net/
ip addr show dev eth1
ifconfig ens7 10.99.0.10/16 up
ip addr flush dev eth0
ifconfig eth0 0.0.0.0 0.0.0.0 && dhclient  
dhclient -r eth0
dhclient eth0

ip route add default via 192.168.1.1

tcpdump -i eno16777736 port 27017

nmap -sV -p6379 127.0.0.1

echo 'check tcp-segmentation-offload, generic-segmentation/receive-offload status'
ethtool -k ens3
ethtool -K ens3 gro off gso off tso off

```

http://darkk.net.ru/redsocks/

## disable ipv6
```
echo "net.ipv6.conf.all.disable_ipv6=1"  >> /etc/sysctl.conf
sysctl  -p
```

# systemd-networkd.service
/usr/lib/systemd/systemd-networkd
https://wiki.archlinux.org/index.php/systemd-networkd
https://www.freedesktop.org/software/systemd/man/systemd.netdev.html#

```
systemctl status systemd-networkd.service
systemctl restart systemd-networkd.service

# networkctl lisft
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
local administration network directory `/etc/systemd/network`
system network directory `/usr/lib/systemd/network`
volatile runtime network directory `/run/systemd/network`
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
```
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
```

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

# Firewall
## iptables
```
iptables -I INPUT -i docker0 -j ACCEPT
iptables -I INPUT -s  localhost -j ACCEPT

iptables -A INPUT --dport 81 -j DROP
iptables -A INPUT -p tcp -m multiport  --dport 3306,6379 -j DROP
iptables -A INPUT -p udp --dport 161 -j ACCEPT
iptables-save
iptables -L --line-numbers
iptables -D INPUT 2
```
## CentOS
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
## Ubuntu 16
```
sudo ufw allow 11200:11299/tcp
sudo ufw status verbose
sudo ufw disable
```