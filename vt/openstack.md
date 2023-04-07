<!-- TOC -->

- [Components](#components)
- [Releases](#releases)
- [Hardware requirements & design](#hardware-requirements--design)
- [devstack](#devstack)
- [Ubuntu conjure-up](#ubuntu-conjure-up)
- [RDO/Packstack](#rdopackstack)
- [Instance Images](#instance-images)

<!-- /TOC -->
# Components
https://en.wikipedia.org/wiki/OpenStack#Components

    Compute (Nova)
    Networking (Neutron)
    Block storage (Cinder)
    Identity (Keystone)
    Image (Glance)
    Object storage (Swift)
    Dashboard (Horizon)
    Orchestration (Heat)
    Workflow (Mistral)
    Telemetry (Ceilometer)
    Database (Trove)
    Elastic map reduce (Sahara)
    Bare metal (Ironic)
    Messaging (Zaqar)
    Shared file system (Manila)
    DNS (Designate)
    Search (Searchlight)
    Key manager (Barbican)
    Container orchestration (Magnum)
    Rule-based alarm actions (Aodh)

# Releases
https://releases.openstack.org/

    Series	Status	Initial Release Date	Next Phase	EOL Date
    Queens	Under Development	scheduled	 	TBD
    Pike	Phase I – Latest release	2017-08-30	Phase II – Maintained release on 2018-02-26	2018-09-03
    Ocata	Phase II – Maintained release	2017-02-22	Phase III – Legacy release on 2018-02-26	2018-02-26
    Newton	Phase II – Maintained release	2016-10-06	Phase III – Legacy release on 2017-10-09	2017-10-11
    Mitaka	EOL	2016-04-07	 	2017-04-10
    Liberty	EOL	2015-10-15	 	2016-11-17
    Kilo	EOL	2015-04-30	 	2016-05-02
    Juno	EOL	2014-10-16	 	2015-12-07
    Icehouse	EOL	2014-04-17	 	2015-07-02
    Havana	EOL	2013-10-17	 	2014-09-30
    Grizzly	EOL	2013-04-04	 	2014-03-29
    Folsom	EOL	2012-09-27	 	2013-11-19
    Essex	EOL	2012-04-05	 	2013-05-06
    Diablo	EOL	2011-09-22	 	2013-05-06
    Cactus	Deprecated	2011-04-15
    Bexar	Deprecated	2011-02-03
    Austin	Deprecated	2010-10-21

# Hardware requirements & design
https://docs.openstack.org/newton/install-guide-rdo/overview.html#example-architecture  
at least two nodes (hosts):controller(2 NICs) + compute(2 NICs)  
Optional services such as Block Storage and Object Storage require additional nodes.

# devstack
http://docs.openstack.org/developer/devstack/guides/single-machine.html  
Use of postgresql in devstack is deprecated, and will be removed during the Pike cycle

    export GIT_BASE=http://github.com  # fix git clone hangs issue
    export no_proxy=127.0.0.1,192.168.88.15    # don't use *; fix: Could not determine a suitable URL for the plugin

    sudo useradd -s /bin/bash -d /opt/stack -m stack
    echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
    sudo su - stack
    git clone https://git.openstack.org/openstack-dev/devstack

    ./stack.sh:main:224     xenial|yakkety|zesty|stretch|jessie|f24|f25|f26|opensuse-42.2|opensuse-42.3|rhel7|kvmibm1

http://docs.openstack.org/developer/openstack-ansible/developer-docs/quickstart-aio.html  
https://developer.rackspace.com/blog/life-without-devstack-openstack-development-with-osa/  

# Ubuntu conjure-up
http://conjure-up.io/docs/en/users/#getting-started

    snap install conjure-up --classic
    conjure-up openstack

# RDO/Packstack
https://www.rdoproject.org/install/packstack/

    sudo systemctl disable firewalld
    sudo systemctl stop firewalld
    sudo systemctl disable NetworkManager
    sudo systemctl stop NetworkManager
    sudo systemctl enable network
    sudo systemctl start network

    yum install -y centos-release-openstack-pike && \
    yum update -y  && \
    yum install -y openstack-packstack && \
    packstack --allinone || packstack --answer-file=FILE    

# Instance Images
http://docs.openstack.org/image-guide/obtain-images.html  
http://cdimage.debian.org/cdimage/openstack/  
http://linuximages.de/openstack/arch/    