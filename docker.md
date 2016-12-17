<!-- TOC -->

- [Install(kernel>=3.10)](#installkernel310)
- [Swarm](#swarm)

<!-- /TOC -->

# Install(kernel>=3.10)
```
curl -fsSL https://get.docker.com/ | sh
sudo systemctl enable docker.service
sudo systemctl start docker
```

# Swarm
TCP port 2377 for cluster management communications
TCP and UDP port 7946 for communication among nodes
TCP and UDP port 4789 for overlay network traffic

If you are planning on creating an overlay network with encryption (--opt encrypted), you will also need to ensure protocol 50 (ESP) is open.