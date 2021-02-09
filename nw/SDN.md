<!-- TOC -->

- [Courses](#courses)
- [Mininet](#mininet)
    - [Install](#install)
    - [Supported switch & controller](#supported-switch--controller)
    - [Run](#run)
    - [Remote control](#remote-control)
- [Switch - C - Open vSwitch - OpenFlow 1.0+](#switch---c---open-vswitch---openflow-10)
- [Switch - C - Lagopus - OpenFlow 1.3](#switch---c---lagopus---openflow-13)
- [Switch - C - OpenFlow 1.3 Software Switch](#switch---c---openflow-13-software-switch)
- [Controller - Python - Faucet - OpenFlow 1.3](#controller---python---faucet---openflow-13)
    - [Docs](#docs)
    - [faucet.yaml](#faucetyaml)
        - [DP](#dp)
        - [Port](#port)
        - [Router](#router)
        - [VLAN](#vlan)
    - [Manually install](#manually-install)
    - [Docker](#docker)
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
http://zoo.cs.yale.edu/classes/cs434/cs434-2017-spring/lectures/02-prognet-openflow.pdf  
https://www.youtube.com/playlist?list=PLpherdrLyny8YN4M24iRJBMCXkLcGbmhY  

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

# Switch - C - Open vSwitch - OpenFlow 1.0+
[OVS](./ovs)

# Switch - C - Lagopus - OpenFlow 1.3
https://github.com/lagopus/lagopus  
VLAN, QinQ, MAC-in-MAC, MPLS and PBB.  
tunnel protocol processing for overlay-type networking with GRE, VxLAN and GTP.
Memory: 2GB or more  

# Switch - C - OpenFlow 1.3 Software Switch
https://github.com/CPqD/ofsoftswitch13

# Controller - Python - Faucet - OpenFlow 1.3
http://faucet.nz/  
for multi table OpenFlow 1.3 switches, that implements layer 2 switching, VLANs, ACLs, and layer 3 IPv4 and IPv6 routing, static and via BGP.

## Docs
http://docs.openvswitch.org/en/latest/tutorials/faucet/#overview  
https://github.com/faucetsdn/faucet/tree/master/docs [PDF](https://media.readthedocs.org/pdf/faucet/latest/faucet.pdf)  
http://costiser.ro/2017/03/07/sdn-lesson-2-introducing-faucet-as-an-openflow-controller

## faucet.yaml
http://faucet.readthedocs.io/en/latest/configuration.html#configuration-options

### DP
https://github.com/faucetsdn/faucet/blob/master/docs/default_conf_doc.md

| Attribute | Default | Description |
| --------- | ------- | ----------- |
| dp_id | None| Name for this dp, used for stats reporting and configuration | 
| timeout | 300|    inactive MAC timeout | 
| arp_neighbor_timeout | 500|    ARP and neighbor timeout (seconds) | 
| stack | None|    stacking config, when cross connecting multiple DPs | 
| vlan_acl_table | None|   | 
| vlan_table | None|   | 
| port_acl_table | None|    The table for internally associating vlans | 

### Port

| Attribute | Default | Description |
| --------- | ------- | ----------- |
| number | None|   | 
| acl_in | None|   | 
| native_vlan | None|   | 
| tagged_vlans | None|   | 
| permanent_learn | False|   | 
| stack | None|   | 
| unicast_flood | True|   | 
| mirror | None|   | 
| mirror_destination | False|   | 
| max_hosts | 255|   maximum number of hosts | 

### Router

| Attribute | Default | Description |
| --------- | ------- | ----------- |
| vlans | None|   | 

### VLAN

| Attribute | Default | Description |
| --------- | ------- | ----------- |
| acl_in | None|   | 
| routes | None|   | 
| vid | None|   | 
| faucet_vips | None|   | 
| max_hosts | 255|    Limit number of hosts that can be learned on a VLAN. | 
| proactive_arp_limit | None| proactively ARP for hosts (None unlimited) | 
| proactive_nd_limit | None| proactively ND for hosts (None unlimited) | 
| unicast_flood | True|   | 

## Manually install
    sudo pip install faucet
    sudo pip install git+https://github.com/faucetsdn/faucet.git
    sudo vi /etc/ryu/faucet/faucet.yaml
    check_faucet_config.py /etc/ryu/faucet.yaml # verify config
    ryu-manager faucet.faucet --verbose

[FAUCET_LOG_LEVEL / GAUGE_LOG_LEVEL](https://docs.python.org/3/library/logging.html#levels)

## Docker
https://github.com/faucetsdn/faucet/tree/master/etc/ryu/faucet

    wget https://raw.githubusercontent.com/faucetsdn/faucet/master/etc/ryu/faucet/faucet.yaml
    wget https://raw.githubusercontent.com/faucetsdn/faucet/master/etc/ryu/faucet/acls.yaml
    mkdir -p faucet.conf.d && mv -t faucet.conf.d/ faucet.yaml acls.yaml
    docker run -v $(pwd)/faucet.conf.d/:/etc/ryu/faucet/ \
        --net host --name faucet \
        -e FAUCET_LOG_LEVEL='DEBUG' \
        -e GAUGE_LOG_LEVEL='DEBUG' \
        -d faucet/faucet
    netstat -lntup | grep -P '6653|9302'

    docker exec -it faucet cat /var/log/ryu/faucet/faucet.log   # check log
    docker exec faucet pkill -HUP -f faucet.faucet      # update configuration

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
