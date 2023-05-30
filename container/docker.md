<!-- TOC -->

- [Web UI](#web-ui)
- [Scripts](#scripts)
- [Dockerfile code snippets](#dockerfile-code-snippets)
    - [CMD and ENTRYPOINT](#cmd-and-entrypoint)
    - [apt](#apt)
    - [alpine](#alpine)
    - [tini](#tini)
    - [S6 - a process supervisor](#s6---a-process-supervisor)
- [badger](#badger)
- [Storage](#storage)
    - [btrfs issue](#btrfs-issue)
- [Network](#network)
    - [macvlan/ipvlan](#macvlanipvlan)
    - [plugins](#plugins)
    - [DHCP](#dhcp)
- [Commands](#commands)
    - [build](#build)
    - [container/image operations](#containerimage-operations)
    - [cp](#cp)
    - [run](#run)
        - [X11 Forwarding](#x11-forwarding)
    - [container update](#container-update)
    - [Clean up](#clean-up)
    - [Detach](#detach)
- [Config](#config)
    - [Mirrors](#mirrors)
    - [Proxy](#proxy)
- [Swarm](#swarm)
- [OS](#os)
    - [CoreOS](#coreos)
    - [boot2docker](#boot2docker)
- [Windows/Mac](#windowsmac)
- [Automated builds](#automated-builds)

<!-- /TOC -->

# Web UI
https://documentation.portainer.io/v2.0/deploy/ceinstalldocker/

# Scripts

    source /dev/stdin <<< "$(curl -sSL https://raw.githubusercontent.com/fzinfz/scripts/master/linux/docker.sh)"

# Dockerfile code snippets
## CMD and ENTRYPOINT
https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact

    ENTRYPOINT [“exec_entry”, “p1_entry”]
    CMD [“exec_cmd”, “p1_cmd”]
    => exec_entry p1_entry exec_cmd p1_cmd

## apt
```
RUN apt update && apt install -y 
    --no-install-recommends && rm -r /var/lib/apt/lists/*
```

## alpine
```
# install pip3
RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py && rm get-pip.py

RUN apk add --no-cache --virtual .build-deps  \
    curl ca-certificates jq \
    && apk del .build-deps
```

## tini
https://github.com/krallin/tini  

    docker run --init

## S6 - a process supervisor
https://github.com/just-containers/s6-overlay

# badger
https://microbadger.com

# Storage
https://docs.docker.com/storage/storagedriver/select-storage-driver/#docker-engine---community

    When possible, overlay2 is the recommended storage driver. 
    Supported backing filesystems: xfs with ftype=1, ext4 ( where /var/lib/docker/ is located )

http://jpetazzo.github.io/assets/2015-06-04-deep-dive-into-docker-storage-drivers.html#80  

## btrfs issue
https://gist.github.com/hopeseekr/cd2058e71d01deca5bae9f4e5a555440

# Network
none/bridge/host/overlay/{belows}: https://docs.docker.com/network/

## macvlan/ipvlan
https://hicu.be/macvlan-vs-ipvlan   
- Ipvlan：All sub-interfaces share parent’s MAC | vs Macvlan
- Ipvlan L3 mode：Each sub-interface has to be configured with a different subnet
- Macvlan and ipvlan cannot be used on the same parent interface at the same time.

https://docs.docker.com/network/ipvlan/  
- IPvlan L2 mode trunking is the same as Macvlan with regard to gateways and L2 path isolation.
- `--internal`: ( off `-o parent=` )
- if no `--gateway`: gw for `--subnet=192.168.1.0/24` will be 192.168.1.1

To access host, check [/nw/openwrt](/nw/openwrt)

## plugins
https://docs.docker.com/engine/extend/plugins_services/#network-plugins

## DHCP
- https://github.com/homeall/dhcphelper
- https://github.com/modem7/DHCP-Relay

# Commands   
## build
https://docs.docker.com/engine/reference/commandline/build/

    docker build [-f Dockerfile.custom] [--target multi-stage] Dockerfile-Root-Folder

    docker build - < Dockerfile      # no context, local ADD not working
    curl example.com/remote/Dockerfile | docker build -f - .
    Get-Content Dockerfile | docker build - # Powershell

    docker build -f ctx/Dockerfile http://server/ctx.tar.gz
    docker build https://github.com/user/repo.git

|Build Syntax Suffix|Commit Used|Build Context Used|
|---|---|---|
|myrepo.git#mytag:myfolder|refs/tags/mytag|/myfolder|
|myrepo.git#mybranch:myfolder|refs/heads/mybranch|/myfolder|

Squashing does not destroy any existing image, rather it creates a new image.

## container/image operations
    
    docker image tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]

    docker export container_name > container.tar
    docker import [OPTIONS] file|URL|- [REPOSITORY[:TAG]]

    docker save image_name > image.tar
    docker load < image.tar[.gz]

    docker save python | ssh -C 192.168.88.72 docker load

## cp
https://docs.docker.com/engine/reference/commandline/cp/

    docker cp [OPTIONS] CONTAINER:SRC_PATH DEST_PATH|-
    docker cp [OPTIONS] SRC_PATH|- CONTAINER:DEST_PATH
        
## run
https://docs.docker.com/engine/reference/run/  
https://docs.docker.com/engine/admin/resource_constraints/

```
--user=[ user | user:group | uid | uid:gid | user:gid | uid:group ]

-m, --memory=""
-c, --cpu-shares=0	CPU shares (relative weight)
--dns=[]           : Set custom dns servers for the container
--network="bridge" : Connect a container to a network
                      'bridge': create a network stack on the default Docker bridge
                      'none': no networking
                      'container:<name|id>': reuse another container's network stack
                      'host': use the Docker host network stack
                      '<network-name>|<network-id>': connect to a user-defined network
--network-alias=[] : Add network-scoped alias for the container
--add-host=""      : Add a line to /etc/hosts (host:IP)
--mac-address=""   : Sets the container's Ethernet device's MAC address
--ip=""            : Sets the container's Ethernet device's IPv4 address
--link-local-ip=[] : Sets one or more container's Ethernet device's link local IPv4/IPv6 addresses
--read-only        ：prohibiting writes to locations other than the specified volumes

Volume labels  
`:z` => shared  
`:Z` => private

`--entrypoint` will clear out `CMD`

echo test | docker run --rm -i alpine cat
docker run --security-opt seccomp:unconfined  # may fix chromium start error
```

### X11 Forwarding
http://wiki.ros.org/docker/Tutorials/GUI  
https://people.ece.cornell.edu/skand/post/x-forwarding-on-docker/

    --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw"

## container update
https://docs.docker.com/engine/reference/commandline/container_update/

docker container update [OPTIONS] CONTAINER [CONTAINER...]
    --cpus="1.5"        # one and a half of the CPUs
    --cpu-shares , -c
    --memory , -m		Memory limit
    --memory-reservation		Memory soft limit
    --restart

## Clean up

    docker container prune
    docker system prune  # Remove unused data

## Detach

    Ctrl+p & Ctrl+q

# Config
https://docs.docker.com/engine/reference/commandline/dockerd//#daemon-configuration-file
```
/etc/docker/daemon.json     # delete `,` & `#...`
# `dockerd` for debugging: https://docs.docker.com/engine/admin/
{
    "live-restore": true,   # containers remain running if daemon unavailable
    "graph": "/data/docker-fs",
    "storage-driver": "overlay2",
}
```

## Mirrors
CN: https://yeasy.gitbook.io/docker_practice/install/mirror
LAN: https://docs.docker.com/registry/configuration/#proxy

## Proxy
https://docs.docker.com/network/proxy/#configure-the-docker-client  
~/.docker/config.json

https://docs.docker.com/engine/admin/systemd/#httphttps-proxy
```
mkdir -p /etc/systemd/system/docker.service.d

cat > /etc/systemd/system/docker.service.d/http-proxy.conf << EOF
[Service]
Environment="HTTP_PROXY=http://192.168.88.20:1080/" "NO_PROXY=localhost,127.0.0.1,192.168.*.*.172.16.*.*"
EOF

sudo systemctl daemon-reload
systemctl restart docker

systemctl show --property=Environment docker

```

# Swarm
TCP port 2377 for cluster management communications
TCP and UDP port 7946 for communication among nodes
TCP and UDP port 4789 for overlay network traffic
--opt encrypted => protocol 50 (ESP) is open

https://docs.docker.com/engine/swarm/admin_guide/#/add-manager-nodes-for-fault-tolerance
```
docker swarm init --advertise-addr 10.2.0.1
docker swarm join-token manager
docker swarm join-token worker
docker swarm init --force-new-cluster # without losing data

docker node ls
docker node update --label-add server=s1 st

netstat -lntup | egrep '2377|7946|4789|50'

docker service create --name nginx -p 8080:80 --replicas 3 nginx
docker service create --name nginx -p 80:80  -p 443:443 --network web --mode global nginx

docker service ls
docker service ps nginx
docker inspect <ID> | grep Err
```

https://docs.docker.com/engine/reference/commandline/service_create/

    docker network create \
        --driver overlay \
        --subnet 10.66.3.0/24 \
        --opt encrypted \
        web

    docker network ls

    # node IP
    ip addr | grep -P -o '\d+\.\d+\.\d+\.\d+(?=/24)'

    # service VIP
    ip addr | grep -P -o '\d+\.(?!255)\d+\.\d+\.\d+(?=/32)'

# OS
## CoreOS
https://coreos.com/releases/
```
vi /etc/coreos/update.conf
update_engine_client -update
```
    
## boot2docker
https://github.com/boot2docker/boot2docker  
Lightweight Linux for Docker

    echo EXTRA_ARGS="--foo=bar"  >>  /var/lib/boot2docker/profile

# Windows/Mac
https://docs.docker.com/engine/installation/windows/  
https://docs.docker.com/machine/drivers/  
https://forums.docker.com/t/how-can-i-ssh-into-the-betas-mobylinuxvm/10991/

# Automated builds
Docker Hub | $5+/m: https://www.docker.com/pricing/  
Github Actions | 2k min/m: https://docs.docker.com/ci-cd/github-actions/  
Jetbrains Space | 

https://www.jetbrains.com/help/space/docker.html#publish-a-docker-image-to-docker-hub