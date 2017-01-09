<!-- TOC -->

- [Install(kernel>=3.10)](#installkernel310)
    - [Debian Jessie](#debian-jessie)
- [Storage](#storage)
- [Mirror](#mirror)
- [Swarm](#swarm)
- [node IP](#node-ip)
- [service VIP](#service-vip)
- [Run](#run)
- [CoreOS](#coreos)
- [Kubernetes](#kubernetes)

<!-- /TOC -->

# Install(kernel>=3.10)
```
curl -fsSL https://get.docker.com/ | sh

echo deb [arch=amd64] https://apt.dockerproject.org/repo ubuntu-xenial main experimental testing > /etc/apt/sources.list.d/docker.list
apt-get update
apt install -y docker-engine
apt policy docker-engine | head -n 20

sudo systemctl enable docker.service
sudo systemctl start docker
```

## Debian Jessie
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
Ref: https://docs.docker.com/engine/installation/linux/debian/

# Storage
https://docs.docker.com/engine/userguide/storagedriver/selectadriver/  
![](https://docs.docker.com/engine/userguide/storagedriver/images/driver-pros-cons.png)
http://jpetazzo.github.io/assets/2015-06-04-deep-dive-into-docker-storage-drivers.html#80  

# Mirror
V1: https://docs.docker.com/v1.6/articles/registry_mirror/

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
  pub

docker network ls

# node IP
ip addr | grep -P -o '\d+\.\d+\.\d+\.\d+(?=/24)'
# service VIP
ip addr | grep -P -o '\d+\.(?!255)\d+\.\d+\.\d+(?=/32)'

# Run
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