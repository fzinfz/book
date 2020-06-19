<!-- TOC -->

- [NFS](#nfs)
    - [Server](#server)
    - [NFS performance monitoring and tuning](#nfs-performance-monitoring-and-tuning)
    - [client](#client)

<!-- /TOC -->

# NFS
## Server

    apt install nfs-kernel-server

    vi /etc/exports
        /data *(rw,no_root_squash,no_subtree_check)   

    exportfs -a
    systemctl restart nfs-kernel-server

## NFS performance monitoring and tuning
https://www.ibm.com/support/knowledgecenter/en/ssw_aix_71/com.ibm.aix.performance/nfs_perf_mon_tun.htm  
http://www.nfsv4bat.org/Documents/ConnectAThon/2013/NewGenerationofTesting-v2.pdf

## client

    apt install -y nfs-common

    mount.nfs nfs_server:/dir /dir 
    mount -tnfs4 -ominorversion=1 server_nfs_4.1:/dir
    mount -t nfs -o nfsvers=4.1 192.168.4.12:/2T 2T
    mount -v 192.168.88.10:/ /data/  # mount NFS 4.2
    
    umount --force /PATH/OF/BUSY-NFS(NETWORK-FILE-SYSTEM)

    # /etc/fstab
    NFS_server:/    /data nfs rsize=8192,wsize=8192,timeo=14,intr    