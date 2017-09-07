<!-- TOC -->

- [TCP congestion control](#tcp-congestion-control)
- [relayd](#relayd)
- [PF](#pf)
- [ZFS](#zfs)

<!-- /TOC -->

# TCP congestion control

```
sysctl net.inet.tcp.cc
net.inet.tcp.cc.available: newreno
net.inet.tcp.cc.algorithm: newreno

kldload cccubic
kldload ccvegas
kldload cccdg
```

# relayd
https://man.openbsd.org/relayd.conf.5
layer 3 and/or layer 7 load-balancer, application layer gateway, or transparent proxy

# PF
https://man.openbsd.org/pf.conf

    pass in all 
    pass in from any to any 
    pass in proto tcp from any port < 1024 to any 
    pass in proto tcp from any to any port 25 
    pass in proto tcp from 10.0.0.0/8 port >= 1024 \ 
        to ! 10.1.2.3 port != ssh 
    pass in proto tcp from any os "OpenBSD" 
    pass in proto tcp from route "DTAG" 

# ZFS
https://www.freebsd.org/cgi/man.cgi?query=zpool

    zpool create pool_name da0p3 da1p3
    zpool create pool_name \
        mirror da0	da1 \
        mirror da2 da3 \
        log mirror da4 da5
    zpool add pool cache	da2 da3

    zpool list
    zpool get all pool_name
    zpool status pool_name
    zpool iostat -v pool_name 5
    zpool list -v pool_name