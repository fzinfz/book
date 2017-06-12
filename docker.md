<!-- TOC -->

- [Install CE](#install-ce)
    - [Ubuntu](#ubuntu)
    - [Debian Jessie](#debian-jessie)
- [Storage](#storage)
- [Mirror](#mirror)
- [Proxy](#proxy)
- [Move data dir](#move-data-dir)
- [Swarm](#swarm)
- [node IP](#node-ip)
- [service VIP](#service-vip)
- [Run](#run)
- [CoreOS](#coreos)
- [Kubernetes](#kubernetes)

<!-- /TOC -->

# Install CE

## Ubuntu
https://docs.docker.com/engine/installation/linux/ubuntu/#install-using-the-repository
```
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-key fingerprint 0EBFCD88

apt update && apt install -y docker-ce
```

## Debian Jessie
https://docs.docker.com/engine/installation/linux/debian/
```
apt-get purge "lxc-docker*"
apt-get purge "docker.io*"
apt-get install apt-transport-https ca-certificates gnupg2
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo deb http://ftp.de.debian.org/debian jessie-backports main >> /etc/apt/sources.list
echo deb https://apt.dockerproject.org/repo debian-jessie main >> /etc/apt/sources.list
apt-get update
apt-cache policy docker-engine
apt install -y --allow-unauthenticated docker-engine
```

# Storage
https://docs.docker.com/engine/userguide/storagedriver/selectadriver/  
![](https://docs.docker.com/engine/userguide/storagedriver/images/driver-pros-cons.png)
http://jpetazzo.github.io/assets/2015-06-04-deep-dive-into-docker-storage-drivers.html#80  

# Mirror
V1: https://docs.docker.com/v1.6/articles/registry_mirror/
```
echo "DOCKER_OPTS=\"--registry-mirror=http://hub-mirror.c.163.com\"" >> /etc/default/docker
service docker restart
```

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

```
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

# Kubernetes
http://kubernetes.io/docs/getting-started-guides/
