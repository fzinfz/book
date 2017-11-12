<!-- TOC -->

- [Install CE](#install-ce)
    - [on RHEL](#on-rhel)
- [Dockerfile code snippets](#dockerfile-code-snippets)
    - [alpine](#alpine)
    - [apt](#apt)
- [Export & Import](#export--import)
- [Storage](#storage)
- [Proxy](#proxy)
- [Move data dir](#move-data-dir)
- [Swarm](#swarm)
- [node IP](#node-ip)
- [service VIP](#service-vip)
- [Run](#run)
- [CoreOS](#coreos)
- [badger](#badger)
- [Windows/Mac](#windowsmac)
- [China Mirrors](#china-mirrors)
    - [boot2docker](#boot2docker)
- [Security](#security)
- [Tools](#tools)
    - [S6 - a process supervisor](#s6---a-process-supervisor)

<!-- /TOC -->

# Install CE
    curl -fsSL get.docker.com | sh

## on RHEL
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum makecache fast
    sudo yum -y install docker-ce
    sudo systemctl start docker

# Dockerfile code snippets
## alpine
    # install pip3
    wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py && rm get-pip.py

    RUN apt update && apt install -y 
        --no-install-recommends && rm -r /var/lib/apt/lists/*

## apt
    RUN apk add --no-cache --virtual .build-deps  \
        curl ca-certificates jq \
        && apk del .build-deps


# Export & Import
    # Commit a container to image
    docker commit conainter_id  user/image_name:tag

    docker save -o <path> <image name>
    docker load -i <path to image tar file>

# Storage
https://docs.docker.com/engine/userguide/storagedriver/selectadriver/  
![](https://docs.docker.com/engine/userguide/storagedriver/images/driver-pros-cons.png)
http://jpetazzo.github.io/assets/2015-06-04-deep-dive-into-docker-storage-drivers.html#80  

# Proxy
https://docs.docker.com/engine/admin/systemd/#httphttps-proxy
```
mkdir -p /etc/systemd/system/docker.service.d

cat > /etc/systemd/system/docker.service.d/http-proxy.conf << EOF
[Service]
Environment="HTTP_PROXY=http://192.168.88.11:1080/" "NO_PROXY=localhost,127.0.0.1,192.168.*.*.172.16.*.*"
EOF

sudo systemctl daemon-reload
systemctl restart docker

systemctl show --property=Environment docker

```
# Move data dir
```
service docker stop
mv /var/lib/docker /root/data/docker
ln -s /root/data/docker /var/lib/docker
service docker start
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

# Run
https://docs.docker.com/engine/reference/run/

```
--user=[ user | user:group | uid | uid:gid | user:gid | uid:group ]

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

echo test | docker run --rm -i alpine cat
```

Volume labels  
`:z` => shared  
`:Z` => private

`--entrypoint` will clear out `CMD`

# CoreOS
https://coreos.com/releases/
```
vi /etc/coreos/update.conf
update_engine_client -update
```

# badger
https://microbadger.com

# Windows/Mac
https://docs.docker.com/engine/installation/windows/  
https://docs.docker.com/machine/drivers/  
https://forums.docker.com/t/how-can-i-ssh-into-the-betas-mobylinuxvm/10991/

# China Mirrors
https://cr.console.aliyun.com/#/accelerator

https://servers.ustclug.org/2015/05/new-docker-hub-registry-mirror/ 
```
docker login -u anonymouse -p anonymouse docker.mirrors.ustc.edu.cn 
```

https://cr.console.aliyun.com/#/accelerator

```
echo "DOCKER_OPTS=\"--registry-mirror=http://hub-mirror.c.163.com\"" >> /etc/default/docker
service docker restart
```

## boot2docker
https://github.com/boot2docker/boot2docker
```
echo EXTRA_ARGS="--registry-mirror=https://docker.mirrors.ustc.edu.cn"  >>  /var/lib/boot2docker/profile
```

# Security
    docker run --security-opt seccomp:unconfined  # may fix chromium start error

# Tools
## S6 - a process supervisor
https://github.com/just-containers/s6-overlay