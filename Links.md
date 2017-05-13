<!-- TOC -->

- [Networking](#networking)
    - [MAC addresss <-> Vender:](#mac-addresss---vender)
    - [Subnetting](#subnetting)
    - [DHCP](#dhcp)
    - [Optimization](#optimization)
        - [TC](#tc)
        - [TCP BBR: Congestion-Based Congestion Control](#tcp-bbr-congestion-based-congestion-control)
    - [Introspectable tunnels to localhost](#introspectable-tunnels-to-localhost)
- [Sync](#sync)
- [Shell](#shell)
    - [UEFI Shell](#uefi-shell)
- [Git](#git)
- [Hardware](#hardware)
- [Linux](#linux)
- [Virtualization](#virtualization)
    - [IOMMU](#iommu)
    - [Openstack](#openstack)
        - [Images](#images)
    - [LXD](#lxd)
    - [Vagrant](#vagrant)
    - [QEMU](#qemu)
- [Docker](#docker)
    - [Tools](#tools)
    - [Linux based On Windows/Mac](#linux-based-on-windowsmac)
    - [China Mirrors](#china-mirrors)
        - [boot2docker(https://github.com/boot2docker/boot2docker)](#boot2dockerhttpsgithubcomboot2dockerboot2docker)
- [MySQL Cluster](#mysql-cluster)
- [Data](#data)
- [Cloud](#cloud)
    - [Pricing](#pricing)
        - [Instance](#instance)
        - [Traffic](#traffic)
    - [Free](#free)
    - [Trial](#trial)
- [Hardware](#hardware-1)

<!-- /TOC -->

# Networking
## MAC addresss <-> Vender:
http://aruljohn.com/mac.pl

## Subnetting
http://www.balticnetworkstraining.com/subnet-calculator/  
http://www.mikrotik.com/img/netaddresses2.pdf

## DHCP
Options: http://www.iana.org/assignments/bootp-dhcp-parameters/bootp-dhcp-parameters.xhtml

## Optimization
https://fasterdata.es.net/assets/Papers-and-Publications/100G-Tuning-TechEx2016.tierney.pdf

### TC
http://events.linuxfoundation.org/sites/events/files/slides/Linux_traffic_control.pdf   

### TCP BBR: Congestion-Based Congestion Control
https://www.ietf.org/proceedings/97/slides/slides-97-iccrg-bbr-congestion-control-02.pdf   
http://www.thequilt.net/wp-content/uploads/BBR-TCP-Opportunities.pdf
http://queue.acm.org/detail.cfm?id=3022184
http://netdevconf.org/1.2/slides/oct5/04_Making_Linux_TCP_Fast_netdev_1.2_final.pdf

## Introspectable tunnels to localhost
https://github.com/inconshreveable/ngrok
https://github.com/fatedier/frp
https://github.com/lovedboy/gortcp

# Sync
https://www.resilio.com/platforms/desktop/

# Shell
http://explainshell.com/
https://www.netsarang.com/xshell_download.html
## UEFI Shell
https://software.intel.com/en-us/articles/uefi-shell

# Git
https://rawgit.com/  
http://nbviewer.jupyter.org/

# Hardware
CPUID to arch: https://github.com/mer-tools/oprofile/blob/master/libop/op_hw_specific.h#L119  
CPU flags：http://unix.stackexchange.com/questions/43539/what-do-the-flags-in-proc-cpuinfo-mean  

# Linux
Free RHEL： https://developers.redhat.com/articles/no-cost-rhel-faq/  

# Virtualization
## IOMMU
https://pve.proxmox.com/wiki/Pci_passthrough
https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF
https://wiki.debian.org/VGAPassthrough

https://github.com/awilliam/rom-parser

## Openstack
http://conjure-up.io/docs/en/users/#getting-started

http://docs.openstack.org/developer/devstack/  
http://docs.openstack.org/developer/devstack/guides/single-machine.html

http://docs.openstack.org/developer/openstack-ansible/developer-docs/quickstart-aio.html  
https://developer.rackspace.com/blog/life-without-devstack-openstack-development-with-osa/  

### Images
http://docs.openstack.org/image-guide/obtain-images.html  
http://cdimage.debian.org/cdimage/openstack/
http://linuximages.de/openstack/arch/

## LXD
https://www.ubuntu.com/cloud/lxd
http://insights.ubuntu.com/2016/03/14/the-lxd-2-0-story-prologue/
https://insights.ubuntu.com/2016/04/13/stephane-graber-lxd-2-0-docker-in-lxd-712/  

https://github.com/lxc/lxd#how-can-i-run-docker-inside-a-lxd-container

## Vagrant
https://atlas.hashicorp.com/boxes/  
Get Direct link: https://github.com/everyx/vagrant-box-download-helper-everyx.user.js

## QEMU
disk convert: https://cloudbase.it/qemu-img-windows/  
[Building ARM containers on any x86 machine, even DockerHub](https://resin.io/blog/building-arm-containers-on-any-x86-machine-even-dockerhub/)

# Docker
## Tools
https://microbadger.com

## Linux based On Windows/Mac
https://docs.docker.com/engine/installation/windows/  
https://docs.docker.com/machine/drivers/  
https://forums.docker.com/t/how-can-i-ssh-into-the-betas-mobylinuxvm/10991/

## China Mirrors
https://hpc.aliyun.com/doc/docker%E9%95%9C%E5%83%8F%E6%9C%8D%E5%8A%A1  
https://servers.ustclug.org/2015/05/new-docker-hub-registry-mirror/ 
```
docker login -u anonymouse -p anonymouse docker.mirrors.ustc.edu.cn 
```

### boot2docker(https://github.com/boot2docker/boot2docker)
```
echo EXTRA_ARGS="--registry-mirror=https://docker.mirrors.ustc.edu.cn"  >>  /var/lib/boot2docker/profile
```
# MySQL Cluster
http://severalnines.com/blog/mysql-docker-introduction-docker-swarm-mode-and-multi-host-networking
https://dev.mysql.com/doc/refman/5.7/en/mysql-cluster-ndb-innodb-engines.html


# Data
https://docs.wso2.com/display/DSS301/Excel+Sample

# Cloud
## Pricing
https://aws.amazon.com/free/  
https://aws.amazon.com/ec2/pricing/  
https://aws.amazon.com/ec2/pricing/reserved-instances/pricing/
https://aws.amazon.com/blogs/aws/ec2-update-t2-nano-instances-now-available/
Traffic: https://aws.amazon.com/ec2/pricing/on-demand/
https://calculator.s3.amazonaws.com/index.html

https://azure.microsoft.com/en-us/pricing/calculator/   
https://azure.microsoft.com/en-us/pricing/details/app-service/  
https://azure.microsoft.com/en-us/pricing/details/bandwidth/

https://cloud.google.com/pricing/  
https://cloud.google.com/compute/pricing  
https://cloud.google.com/storage/pricing

### Instance
Amazon: 5% vGPU + 0.5GB, 3 Year Reserved Instance $69
Google: 20% vGPU + 0.60GB,	Free - $4.09
Microsoft: 1vGPU + 0.75 GiB, 	~$13.40/mo

### Traffic
Amazon: 1GB to 10 TB / month $0.090 per GB, Singapore to China 	$0.120 per GB
Google: $0.12 - $0.23 / GB, Singapore to China $0.23
Microsoft: 5 GB - 10 TB 2 /Month $0.087 - $0.181 per GB, Japan to China $0.138 per GB

https://www.vultr.com/pricing/  
https://www.linode.com/pricing   
https://www.digitalocean.com/pricing/

https://www.aliyun.com/price/product?#/ecs/detail (Compute)  
https://help.aliyun.com/document_detail/25382.html (HDD)  
https://www.qcloud.com/document/product/213/2179  
https://www.qingcloud.com/pricing/plan
https://www.sinacloud.com/index/price.html   
https://www.daocloud.io/pricing/public.html  

## Free 
https://tryappservice.azure.com 

## Trial
http://aws.amazon.com/free/
https://cloud.google.com/free-trial/
https://azure.microsoft.com/en-us/offers/ms-azr-0044p/
 
DigitalOcean $20: https://cloud.docker.com

# Hardware
RS232 3pin： http://flykof.pixnet.net/blog/post/24074586-rs232%E7%B0%A1%E5%96%AE%E6%8E%A5%E6%B3%95(3%E7%B7%9A)