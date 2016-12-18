<!-- TOC -->

- [Install(kernel>=3.10)](#installkernel310)
    - [Debian Jessie](#debian-jessie)
- [Swarm](#swarm)

<!-- /TOC -->

# Install(kernel>=3.10)
```
curl -fsSL https://get.docker.com/ | sh
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
apt-get install docker-engine
```
Ref: https://docs.docker.com/engine/installation/linux/debian/

# Swarm
TCP port 2377 for cluster management communications
TCP and UDP port 7946 for communication among nodes
TCP and UDP port 4789 for overlay network traffic

If you are planning on creating an overlay network with encryption (--opt encrypted), you will also need to ensure protocol 50 (ESP) is open.
```
docker swarm init --advertise-addr 1.2.3.4

swarm join-token manager
docker swarm join-token worker

docker node ls

```