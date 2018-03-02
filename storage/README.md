<!-- TOC -->

- [FUSE](#fuse)
- [Compare](#compare)
- [Gluster - C](#gluster---c)
    - [Types of Volumes](#types-of-volumes)
    - [RDMA(Remote direct memory access)](#rdmaremote-direct-memory-access)
- [Ceph - C++](#ceph---c)
    - [Docker](#docker)
    - [CACHE TIERING](#cache-tiering)
    - [UI - inkscope](#ui---inkscope)
- [Rook - Go](#rook---go)
- [IPFS](#ipfs)
- [Backup](#backup)
    - [duplicati](#duplicati)

<!-- /TOC -->

# FUSE
![](https://cloud.githubusercontent.com/assets/10970993/7412530/67a544ae-ef61-11e4-8979-97dad4031a81.png)

# Compare
https://www.redhat.com/en/technologies/storage  
CEPH: Provides a robust, highly scalable block, object, and filesystem storage platform for modern workloads, like cloud infrastructure and data analytics. Consistently ranked as preferred storage option by OpenStack® users.  
Gluster: Provides a scalable, reliable, and cost-effective data management platform, streamlining file and object access across physical, virtual, and cloud environments.  

http://cecs.wright.edu/~pmateti/Courses/7370/Lectures/DistFileSys/distributed-fs.html

|	|HDFS|iRODS|Ceph|GlusterFS|Lustre|
|---|---|---|---|---|
|Arch|Central|Central|Distributed|Decentral|Central|
|Naming|Index|Database|CRUSH|EHA|Index|
|API|CLI, FUSE|CLI, FUSE|FUSE, mount|FUSE, mount|FUSE|
|REST|REST| |REST| | |
|Fault-detect|Fully connect.|P2P|Fully connect.|Detected|Manually|
|sys-avail|No-failover|No-failover|High|High|Failover|
|data-aval|Replication|Replication|Replication|RAID-like|No|
|Placement|Auto|Manual|Auto|Manual|No|
|Replication|Async.|Sync.|Sync.|Sync.|RAID-like|
|Cache-cons|WORM, lease|Lock|Lock|No|Lock|
|Load-bal|Auto|Manual|Manual|Manual|No|

http://www.youritgoeslinux.com/impl/storage/glustervsceph

# Gluster - C
software defined distributed storage that can scale to several petabytes.  
It provides interfaces for object, block and file storage.  
http://docs.gluster.org/en/latest/Quick-Start-Guide/Architecture/

## Types of Volumes

    gluster volume create test-volume \
        server1:/exp1 server2:/exp2 server3:/exp3 server4:/exp4 # Distributed
        replica 2 transport tcp server1:/exp1 server2:/exp2     # Replicated, w/ data redundancy
        replica 2 transport tcp server1:/exp1 ... server4:/exp4 # R->D

![](https://cloud.githubusercontent.com/assets/10970993/7412402/23a17eae-ef60-11e4-8813-a40a2384c5c2.png)

        stripe 2 transport tcp server1:/exp1 server2:/exp2      # Striped
        stripe 4 transport tcp server1:/exp1 ... server8:/exp8  # S->D

![](https://cloud.githubusercontent.com/assets/10970993/7412394/0ce267d2-ef60-11e4-9959-43465a2a25f7.png)

        stripe 2 replica 2 transport tcp server1:/exp1 ... server4:/exp4   # R->S （*）
        stripe 2 replica 2 transport tcp server1:/exp1 ... server8:/exp8   # R->S->D （*）
       （*） only for Map Reduce workloads

https://access.redhat.com/documentation/en-us/red_hat_gluster_storage/3/html/administration_guide/creating_distributed_striped_replicated_volumes

![](https://access.redhat.com/webassets/avalon/d/Red_Hat_Gluster_Storage-3-Administration_Guide-en-US/images/6a99f99e5f10902a624ee9aa86bd6a0e/6156.png)

![](https://cloud.githubusercontent.com/assets/10970993/7412405/3563ac48-ef60-11e4-823f-ee6100c65ad7.png)

        <Dispersed Volume Usable size> = <Brick size> * (#Bricks - Redundancy)
        bricks#(>=3) > 2 * redundancy

        [disperse [<count>]] [redundancy <count, default=auto>]

        disperse 4 server{1..4}:/bricks/test-volume # Dispersed
        disperse 3 server1:/brick{1..3} # Dispersed             (#)
        disperse 3 server1:/brick{1..6} # Distributed Dispersed (#)
        (#) on the same server, add `force`

https://access.redhat.com/documentation/en-us/red_hat_gluster_storage/3.1/html/administration_guide/chap-red_hat_storage_volumes-creating_dispersed_volumes_1

![](https://access.redhat.com/webassets/avalon/d/Red_Hat_Storage-3.1-Administration_Guide-en-US/images/b33ee87623efd06c3a9cd2b7b908611a/Dispersed_Volume.png)

https://access.redhat.com/documentation/en-us/red_hat_gluster_storage/3.1/html/administration_guide/chap-recommended-configuration_dispersed

        disperse-data 8 redundancy 4 transport tcp 
        server1:/exp/brick1 server1:/exp/brick2 server1:/exp/brick3 server1:/exp/brick4 server2:/exp/brick1 server2:/exp/brick2 server2:/exp/brick3 server2:/exp/brick4 server3:/exp/brick1 server3:/exp/brick2 server3:/exp/brick3 server3:/exp/brick4 server1:/exp/brick5 server1:/exp/brick6 server1:/exp/brick7 server1:/exp/brick8 server2:/exp/brick5 server2:/exp/brick6 server2:/exp/brick7 server2:/exp/brick8  server3:/exp/brick5 server3:/exp/brick6 server3:/exp/brick7 server3:/exp/brick8 server1:/exp/brick9 server1:/exp/brick10 server1:/exp/brick11 server1:/exp/brick12 server2:/exp/brick9 server2:/exp/brick10 server2:/exp/brick11 server2:/exp/brick12 server3:/exp/brick9 server3:/exp/brick10 server3:/exp/brick11 server3:/exp/brick12

![](https://access.redhat.com/webassets/avalon/d/Red_Hat_Storage-3.1-Administration_Guide-en-US/images/382f9dde52bb3628080e247895c274b3/recommended_configuraiton_EC.png)

    gluster volume info test-volume
    gluster volume start test-volume

## RDMA(Remote direct memory access)
http://docs.gluster.org/en/latest/Administrator%20Guide/RDMA%20Transport/

As of now only *FUSE client* and gNFS server would support RDMA transport.

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