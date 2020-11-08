<!-- TOC -->

- [Note](#note)
    - [NextCloud](#nextcloud)
- [Sync](#sync)
    - [ResilioSync/BTSync](#resiliosyncbtsync)
- [GPU](#gpu)
    - [OpenCL](#opencl)

<!-- /TOC -->

# Note
## NextCloud
https://github.com/docker-library/docs/blob/master/nextcloud/README.md#using-the-apache-image

    docker run --name nextcloud -d --restart unless-stopped \
        -p 8090:80  -v nextcloud:/var/www/html \
        nextcloud  


# Sync
## ResilioSync/BTSync
https://www.resilio.com/platforms/desktop/
https://download-cdn.resilio.com/stable/windows64/Resilio-Sync_x64.exe  
https://download-cdn.resilio.com/stable/linux-x64/resilio-sync_x64.tar.gz  

# GPU
## OpenCL
    phoronix-test-suite benchmark pts/opencl

    phoronix-test-suite test system/opencl
    # https://download.blender.org/demo/test/cycles_benchmark_20160228.zip