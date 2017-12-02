<!-- TOC -->

- [Courses](#courses)
- [Openflow Roadmap](#openflow-roadmap)
- [Switch](#switch)
    - [C - Open vSwitch - OpenFlow 1.0+](#c---open-vswitch---openflow-10)
        - [Tools](#tools)
        - [Install & Config](#install--config)
        - [Port bonding](#port-bonding)
        - [Port mirroring](#port-mirroring)
        - [Notes](#notes)
    - [C - OpenFlow 1.3 Software Switch - OpenFlow 1.3](#c---openflow-13-software-switch---openflow-13)
    - [C - Lagopus OpenFlow 1.3](#c---lagopus-openflow-13)
- [Mininet](#mininet)
    - [Install](#install)
    - [Supported switch & controller](#supported-switch--controller)
    - [Run](#run)
    - [Remote control](#remote-control)
- [Controller - Python - Faucet - OpenFlow 1.3](#controller---python---faucet---openflow-13)
    - [Docker](#docker)
    - [ovs-vsctl](#ovs-vsctl)
    - [Config with ACL and router](#config-with-acl-and-router)
- [Controller - Python - Ryu](#controller---python---ryu)
    - [Docker](#docker-1)
    - [Writing Your Ryu Application](#writing-your-ryu-application)
    - [Debug](#debug)
- [Controller - OCaml - Frenetic](#controller---ocaml---frenetic)
    - [Source build](#source-build)
    - [Manual](#manual)
    - [Install](#install-1)
- [Controller - C - OVN](#controller---c---ovn)
- [Controller - C++ - OpenContrail by Juniper](#controller---c---opencontrail-by-juniper)
    - [Kubernetes](#kubernetes)
- [Controller - JAVA - ODL](#controller---java---odl)
    - [Releases](#releases)
    - [Ports](#ports)
    - [Docker](#docker-2)
    - [Init](#init)
- [Controller - JAVA - ONOS](#controller---java---onos)
    - [Ports](#ports-1)
    - [Docker](#docker-3)
        - [Cluster](#cluster)
    - [Init](#init-1)
    - [WebUI](#webui)
    - [Running as a service](#running-as-a-service)
    - [Forming a cluster](#forming-a-cluster)
- [Controller - JAVA - Floodlight](#controller---java---floodlight)
- [Controller - Calico](#controller---calico)
- [Controller - Scala/JAVA - MidoNet](#controller---scalajava---midonet)
- [Controller - Ruby - Trema](#controller---ruby---trema)
- [Controller - Powershell - Microsoft SDN](#controller---powershell---microsoft-sdn)
- [Routing framework - Kulfi](#routing-framework---kulfi)
- [Controller - POX(inactive) - python](#controller---poxinactive---python)
- [Controller - More](#controller---more)
- [Open Security Controller - JAVA](#open-security-controller---java)
- [C++ simulation library and framework - OMNeT++](#c-simulation-library-and-framework---omnet)
- [Programming - P4](#programming---p4)

<!-- /TOC -->

# Courses
http://www.cse.wustl.edu/~jain/tutorials/  
http://www.cs.kent.edu/~mallouzi/Software%20Defined%20Networking/  
http://www.cs.fsu.edu/~xyuan/cis5930/  
https://www.cs.princeton.edu/~jrex/papers/  
https://www.youtube.com/playlist?list=PLpherdrLyny8YN4M24iRJBMCXkLcGbmhY  

# Openflow Roadmap
V1.0-1.5: http://speed.cis.nctu.edu.tw/~ydlin/miscpub/indep_frank.pdf (Page 5)

# Switch
## C - Open vSwitch - OpenFlow 1.0+
http://docs.openvswitch.org/en/latest/faq/openflow/  
version 2.8: OF 1.0-1.4; 1.5/1.6 missing features  
All current versions of ovs-ofctl enable only OpenFlow 1.0 by default.

    ovs-ofctl -O OpenFlow13 dump-flows br0  # enable support for later versions

https://github.com/openvswitch/ovs

[ovs-vswitchd](http://openvswitch.org/support/dist-docs/ovs-vswitchd.8.html) | 
[ovs-vswitchd.conf.db](http://openvswitch.org/support/dist-docs/ovs-vswitchd.conf.db.5.html)  
[ovsdb-server](http://openvswitch.org/support/dist-docs/ovsdb-server.1.html)  
[ovs-dpctl](http://openvswitch.org/support/dist-docs/ovs-dpctl.8.html), a tool for configuring the switch kernel module.  
[ovs-vsctl](http://openvswitch.org/support/dist-docs/ovs-vsctl.8.html), a utility for querying and updating the configuration of ovs-vswitchd.  
[ovs-appctl](http://openvswitch.org/support/dist-docs/ovs-appctl.8.html), a utility that sends commands to running Open vSwitch daemons.  

### Tools
- [ovs-ofctl](http://openvswitch.org/support/dist-docs/ovs-ofctl.8.html), a utility for querying and controlling OpenFlow switches and controllers.  
- [ovs-pki](http://openvswitch.org/support/dist-docs/ovs-pki.8.html), a utility for creating and managing the public-key infrastructure for OpenFlow switches.  
- [ovs-testcontroller](http://openvswitch.org/support/dist-docs/ovs-testcontroller.8.html), a simple OpenFlow controller that may be useful for testing
- A patch to tcpdump that enables it to parse OpenFlow messages.

http://docs.openvswitch.org/en/latest/ref/  
ovn-* ovsdb-* ovs-* vtep[-ctl]  
VTEP: VXLAN Tunnel End Point

### Install & Config
    apt install -y openvswitch-switch
    systemctl status openvswitch-switch.service
    ovs-vswitchd -V # check version

http://docs.openvswitch.org/en/latest/faq/configuration/

    ovs-vsctl add-br br0
    ovs-vsctl add-port br0 eth0             # trunk port (the default)
    ovs-vsctl add-port br0 tap0 tag=9       # access port
    ovs-vsctl add-port br0 eth0 tag=9 vlan_mode=native-tagged

        native-tagged
                A native-tagged port resembles a  trunk  port,  with  the
                exception  that  a  packet  without an 802.1Q header that
                ingresses on a native-tagged  port  is  in  the  ``native
                VLAN’’ (specified in the tag column).

        native-untagged
                A  native-untagged  port  resembles a native-tagged port,
                with the exception that  a  packet  that  egresses  on  a
                native-untagged  port in the native VLAN will not have an
                802.1Q header.

    ovs-vsctl set port tap0 tag=9           # set existing port
    ovs-vsctl set-controller of-switch tcp:0.0.0.0:6633 # set Remote Controller

    ovs-vsctl get Interface eth0 ofport
    ovs-vsctl -- --columns=name,ofport,admin_state,statistics list Interface   # mapping

### Port bonding
    ovs-vsctl add-bond br0 bond0 eth0 eth1  # ovs-vswitchd.conf.db(5) for options

each of the interfaces in my bonded port shows up as an individual OpenFlow port.  
Open vSwitch makes individual bond interfaces visible as OpenFlow ports, rather than the bond as a whole.

### Port mirroring
    # eth0 + tap0 mirrored to tap1
    ovs-vsctl add-port br0 eth0
    ovs-vsctl set bridge br0 stp_enable=true    # not well tested
    ovs-vsctl add-port br0 tap0
    ovs-vsctl add-port br0 tap1 \
        -- --id=@p get port tap1 \
        -- --id=@m create mirror name=m0 select-all=true output-port=@p \
        -- set bridge br0 mirrors=@m
    ovs-vsctl clear bridge br0 mirrors # disable mirror

[RSPAN VLAN](https://github.com/osrg/openvswitch/blob/master/FAQ#L243), mirroring of all traffic to that VLAN. Mirroring to a VLAN can disrupt a network that contains unmanaged switches. 

### Notes
A physical Ethernet device that is part of an Open vSwitch bridge should not have an IP address.

"normalization": a flow cannot match on an L3 field without saying what L3 protocol is in use.

    ovs-ofctl add-flow br0 ip,nw_dst=192.168.0.1,actions=drop
    ovs-ofctl add-flow br0 arp,nw_dst=192.168.0.1,actions=drop

"tp_src=1234" will be ignored. write "tcp,tp_src=1234", or "udp,tp_src=1234".

ofport value -1 means that the interface could not be created due to an error.  
ofport value [] means that the interface hasn't been created yet.

`ovs-dpctl dump-flows` queries a kernel datapath  
`ovs-ofctl dump-flows` queries an OpenFlow switch

[ovs-vsctl with faucet](#ovs-vsctl) | 
[Youtube](https://www.youtube.com/channel/UCH8GBLyxWkJDfZG32kr3Y4g)

## C - OpenFlow 1.3 Software Switch - OpenFlow 1.3
https://github.com/CPqD/ofsoftswitch13

## C - Lagopus OpenFlow 1.3
https://github.com/lagopus/lagopus  
VLAN, QinQ, MAC-in-MAC, MPLS and PBB.  
tunnel protocol processing for overlay-type networking with GRE, VxLAN and GTP.
Memory: 2GB or more  

# Mininet
## Install
    apt install -y  mininet

    git clone https://github.com/mininet/mininet
    mininet/util/install.sh -h

    -a: (default) install (A)ll packages - good luck!
    -b: install controller (B)enchmark (oflops)
    -c: (C)lean up after kernel install
    -d: (D)elete some sensitive files from a VM image
    -e: install Mininet d(E)veloper dependencies
    -f: install Open(F)low
    -i: install (I)ndigo Virtual Switch
    -k: install new (K)ernel
    -m: install Open vSwitch kernel (M)odule from source dir
    -n: install Mini(N)et dependencies + core files
    -p: install (P)OX OpenFlow Controller
    -r: remove existing Open vSwitch packages
    -s <dir>: place dependency (S)ource/build trees in <dir>
    -t: complete o(T)her Mininet VM setup tasks
    -v: install Open (V)switch
    -V <version>: install a particular version of Open (V)switch on Ubuntu
    -w: install OpenFlow (W)ireshark dissector 
    -y: install R(y)u Controller
    -x: install NO(X) Classic OpenFlow controller
    -0: (default) -0[fx] installs OpenFlow 1.0 versions
    -3: -3[fx] installs OpenFlow 1.3 versions

## Supported switch & controller
    default/vs/ovsk=OVSSwitch
    lxbr=LinuxBridge
    user=UserSwitch
    ivs=IVSSwitch
    ovsbr=OVSBridge

    ovsc=OVSController
    none=NullController
    remote=RemoteController
    default=DefaultController
    nox=NOX # NOX_CORE_DIR env var
    ryu=Ryu
    ref=Controller

## Run
http://mininet.org/api/classmininet_1_1topo_1_1Topo.html

    # https://github.com/mininet/mininet/blob/master/custom/topo-2sw-2host.py
    mn --custom mininet/custom/topo-2sw-2host.py --topo mytopo \
       --nat --mac --controller=remote,ip=127.0.0.1,port=6633 \
       -v debug

    mininet> links/dump/net
    mininet> py locals()
    mininet> py h1

## Remote control
https://github.com/mininet/mininet/wiki/FAQ#how-can-i-control-my-mininet-hosts-remotely
https://github.com/mininet/mininet/wiki/FAQ#how-can-i-add-a-rest-interface-to-mininet

# Controller - Python - Faucet - OpenFlow 1.3
http://faucet.nz/  
for multi table OpenFlow 1.3 switches, that implements layer 2 switching, VLANs, ACLs, and layer 3 IPv4 and IPv6 routing, static and via BGP.

    sudo pip install faucet
    sudo pip install git+https://github.com/faucetsdn/faucet.git
    sudo vi /etc/ryu/faucet/faucet.yaml
    check_faucet_config.py /etc/ryu/faucet.yaml # verify config
    ryu-manager faucet.faucet --verbose
    pkill -HUP -f faucet.faucet

## Docker
    # http://docs.openvswitch.org/en/latest/tutorials/faucet/#overview
    wget -O faucet-tutorial.yaml https://git.io/vbLFr
    docker run -v $(pwd)/faucet-tutorial.yaml:/etc/ryu/faucet/faucet.yaml \
        --net host -d --name faucet \
        faucet/faucet
    netstat -lntup | grep 6653

    docker exec -it faucet cat /var/log/ryu/faucet/faucet.log   # check log
    docker exec faucet pkill -HUP -f faucet.faucet      # update configuration

## ovs-vsctl
    IP_faucet=127.0.0.1   # don't use domain name
    ip tuntap add mode tap dev tap1

    ovs-vsctl add-br br0 \
         -- set bridge br0 other-config:datapath-id=0000000000000001 \
         -- set-controller br0 tcp:$IP_faucet:6653 \
         -- set controller br0 connection-mode=out-of-band

    ovs-vsctl add-port br0 tap1 -- set interface tap1 ofport_request=1
    ovs-vsctl add-port br0 tap2 -- set interface tap2 ofport_request=2
    ovs-vsctl add-port br0 tap3 -- set interface tap3 ofport_request=3

    ip addr add 192.168.6.13/24 dev tap3

    cat /var/log/openvswitch/ovs-vswitchd.log
    ovs-vsctl show
    ovs-ofctl dump-flows br0
    ovs-vsctl --if-exists del-br br0

https://github.com/osrg/openvswitch/blob/master/FAQ  
"in-band": controllers are actually part of the network that is being controlled. occasionally they can cause unexpected behavior.

    ovs-appctl bridge/dump-flows br0      # full OpenFlow flow table, including hidden flows
    ovs-vsctl set bridge br0 other-config:disable-in-band=true # disables in-band control entirely

## Config with ACL and router
https://github.com/faucetsdn/faucet/tree/master/etc/ryu/faucet

    wget https://raw.githubusercontent.com/faucetsdn/faucet/master/etc/ryu/faucet/faucet.yaml
    wget https://raw.githubusercontent.com/faucetsdn/faucet/master/etc/ryu/faucet/acls.yaml
    mkdir -p faucet.conf.d && mv -t faucet.conf.d/ faucet.yaml acls.yaml
    docker run -v $(pwd)/faucet.conf.d/:/etc/ryu/faucet/ \

# Controller - Python - Ryu
    git clone git://github.com/osrg/ryu.git

## Docker
    docker run --rm --net host -it -w /root/ryu osrg/ryu

    # start controller & http://server_ip:8080
    PYTHONPATH=. ./bin/ryu run \
        ryu/app/gui_topology/gui_topology.py \
        ryu/app/simple_switch.py \
        --observe-links 

## Writing Your Ryu Application
http://ryu.readthedocs.io/en/latest/writing_ryu_app.html

## Debug
    PyCharm Settings | Python Debugger | Gevent compatible debugging
    ryu-manager = ryu.cmd.manager:main
    ryu = ryu.cmd.ryu_base:main

# Controller - OCaml - Frenetic
https://github.com/frenetic-lang/frenetic (.ova provided)
http://www-users.cselabs.umn.edu/classes/Spring-2016/csci8211/Lecture-Notes/csci8211-Frenetic-Pyretic.pptx

## Source build
    mkdir src && cd src
    git clone https://github.com/frenetic-lang/frenetic
    cd ..
    opam pin add frenetic src/frenetic -n -k git
    opam install -y frenetic
    sudo pip install -e  src/frenetic/lang/python

## Manual
    git clone https://github.com/frenetic-lang/manual.git
    cd programmers_guide/code
    programmers_guide/frenetic_programmers_guide.pdf

## Install
https://gist.githubusercontent.com/basus/cd48c8e4e9d14f853cea4f45f7e0edaf/raw/b6d698a16e1de5fa7d0daef7f7a36a57a9766ae1/frenetic.sh

# Controller - C - OVN
https://docs.openstack.org/networking-ovn/latest/admin/features.html

# Controller - C++ - OpenContrail by Juniper
http://www.opencontrail.org/opencontrail-quick-start-guide/

    DB node: Cassandra database and Zookeeper.
    Configuration Node: Neutron server, configuration API server, IF-MAP server, discovery server and configuration related services.
    Analytics Node: the analytics data collector, operational and analytics API server and Query engine.
    Web UI: the web-server and web job-server
    Control node: BGP speaker, DNS server and named
    Compute node: the vRouter a kernel loadable module and a user space vRouter agent, along with Openstack compute services.

## Kubernetes
    https://github.com/Juniper/contrail-controller/wiki/Kubernetes

# Controller - JAVA - ODL
## Releases
    Hydrogen	February 2014
    Helium	October 2014
    Lithium	June 2015
    Beryllium	February 2016
    Boron	November 2016
    Carbon	June 2017
    Nitrogen	September 2017

## Ports
https://wiki.opendaylight.org/view/Ports

## Docker
https://hub.docker.com/r/opendaylight/odl/  

## Init
    feature:install odl-restconf odl-l2switch-switch odl-mdsal-apidocs odl-dlux-core \
        odl-dluxapps-nodes odl-dluxapps-topology \
        odl-dluxapps-yangui odl-dluxapps-yangvisualizer odl-dluxapps-yangman    
    # visit http://server_ip:8080/index.html    # admin/admin

# Controller - JAVA - ONOS
![](https://en.wikipedia.org/wiki/File:ONOS-Tiers.png)

## Ports
    8181    for REST API and GUI
    8101    to access the ONOS CLI (SSH)
    9876    for intra-cluster communication (communication between target machines)
    6653    optional, for OpenFlow
    6640    optional, for OVSDB

## Docker
    docker run --name onos -d --net host --restart unless-stopped onosproject/onos:1.11.1
    ssh -p 8101 onos@server_ip

### Cluster
https://wiki.onosproject.org/display/ONOS/Running+the+published+Docker+ONOS+images  

## Init
    onos> (or Web UI)
        apps -a -s
        app activate org.onosproject.openflow
        app activate org.onosproject.fwd
        add-host-intent <tab>

## WebUI
http://server_ip:8181/onos/ui/login.html # onos/rocks

## Running as a service
https://wiki.onosproject.org/display/ONOS/Running+ONOS+as+a+service

## Forming a cluster
Form a cluster of three instances, from one of the target machines

    /opt/onos/bin/onos-form-cluster $TARGET_MACHINE_1_IP ... $TARGET_MACHINE_N_IP

# Controller - JAVA - Floodlight
https://floodlight.atlassian.net/wiki/spaces/floodlightcontroller/pages/1343544/Installation+Guide

    sudo apt-get install build-essential ant maven python-dev
    git clone git://github.com/floodlight/floodlight.git
    cd floodlight
    git submodule init
    git submodule update
    ant
    sudo mkdir /var/lib/floodlight
    sudo chmod 777 /var/lib/floodlight

# Controller - Calico
https://github.com/projectcalico/calico  
enabling cloud native application connectivity and policy  
integrates with Kubernetes, Apache Mesos, Docker, OpenStack and more

# Controller - Scala/JAVA - MidoNet
https://github.com/midonet/midonet  
use with OpenStack, vanilla Linux hosts, Docker, Mesos, etc.  
MidoNet supports virtual L2 switches, virtual L3 routing, distributed, stateful source NAT and distributed stateful L4 TCP load balancing.

    curl -sL quickstart.midonet.org | sudo bash

# Controller - Ruby - Trema
https://github.com/trema/trema

# Controller - Powershell - Microsoft SDN
https://github.com/Microsoft/SDN

# Routing framework - Kulfi
https://github.com/merlin-lang/kulfi  

# Controller - POX(inactive) - python
http://en.community.dell.com/techcenter/networking/w/wiki/3820.openvswitch-openflow-lets-get-started

# Controller - More
http://yuba.stanford.edu/~casado/of-sw.html  
https://www.sdxcentral.com/sdn/definitions/sdn-controllers/open-source-sdn-controllers/

# Open Security Controller - JAVA
https://www.opensecuritycontroller.org/documentation/tutorials/openstack_workload/

# C++ simulation library and framework - OMNeT++
https://omnetpp.org/models

# Programming - P4
http://www.inf.usi.ch/faculty/soule/teaching/2015-fall/netpl/
https://p4.org/
