<!-- TOC -->

- [FUSE](#fuse)
- [Gluster - C](#gluster---c)
    - [Types of Volumes](#types-of-volumes)
- [Ceph - C++](#ceph---c)
    - [Docker](#docker)
    - [CACHE TIERING](#cache-tiering)
    - [UI - inkscope](#ui---inkscope)
- [Compare](#compare)
- [Rook - Go](#rook---go)
- [IPFS](#ipfs)
- [Backup](#backup)
    - [duplicati](#duplicati)

<!-- /TOC -->

# FUSE
![](https://cloud.githubusercontent.com/assets/10970993/7412530/67a544ae-ef61-11e4-8979-97dad4031a81.png)

# Gluster - C
software defined distributed storage that can scale to several petabytes.  
It provides interfaces for object, block and file storage.  
http://docs.gluster.org/en/latest/Quick-Start-Guide/Architecture/

## Types of Volumes
1. Distributed Glusterfs Volume
2. Replicated Glusterfs Volume
3. Distributed Replicated Glusterfs Volume (1+2)
4. Striped Glusterfs Volume
5. Distributed Striped Glusterfs Volume(1+4)

# Ceph - C++
Ceph uniquely delivers object, block, and file storage in one unified system.  
A Ceph Storage Cluster consists of two types of daemons:
* Ceph Monitor: maintains a master copy of the cluster map
* Ceph OSD Daemon: checks its own state and the state of other OSDs and reports back to monitors.

![](http://docs.ceph.com/docs/jewel/_images/stack.png)

## Docker
http://hub.docker.com/r/ceph/

## CACHE TIERING
![](http://docs.ceph.com/docs/master/_images/ditaa-2982c5ed3031cac4f9e40545139e51fdb0b33897.png)

## UI - inkscope
https://github.com/inkscope/inkscope (with screenshots)  
![](https://github.com/inkscope/inkscope/raw/master/documentation/inkscope-platform.png)

# Compare
https://www.redhat.com/en/technologies/storage  
CEPH: Provides a robust, highly scalable block, object, and filesystem storage platform for modern workloads, like cloud infrastructure and data analytics. Consistently ranked as preferred storage option by OpenStack® users.  
Gluster: Provides a scalable, reliable, and cost-effective data management platform, streamlining file and object access across physical, virtual, and cloud environments.  

http://cecs.wright.edu/~pmateti/Courses/7370/Lectures/DistFileSys/distributed-fs.html (11 DFS Comparison)  
http://www.youritgoeslinux.com/impl/storage/glustervsceph

# Rook - Go
File, Block, and Object Storage Services for your Cloud-Native Environment  
https://rook.github.io/docs/rook/master/kubernetes.html
![](https://rook.github.io/docs/rook/master/media/rook-architecture.png)
![](https://rook.github.io/docs/rook/master/media/kubernetes.png)

# IPFS
https://github.com/ipfs/ipfs  

    combines Kademlia + BitTorrent + Git
    mountable filesystem (via FUSE)
    http://ipfs.io/<path>

# Backup
## duplicati
https://github.com/duplicati/duplicati  
https://www.duplicati.com/screenshots/  
Store securely encrypted backups in the cloud!  
Amazon S3, OneDrive, Google Drive, Rackspace Cloud Files, HubiC, Backblaze (B2), Amazon Cloud Drive (AmzCD), Swift / OpenStack, WebDAV, SSH (SFTP), FTP, and more!