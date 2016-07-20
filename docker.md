# Registry
## Deploying a registry server
https://github.com/docker/distribution/blob/master/docs/deploying.md  

## Connect mirror on boot2docker
```
docker-machine ssh default 

echo EXTRA_ARGS="--registry-mirror=https://docker.mirrors.ustc.edu.cn"  >>  /var/lib/boot2docker/profile

docker login -u anonymouse -p anonymouse docker.mirrors.ustc.edu.cn 

```
# Windows Related
## VM installed with [boot2docker](http://boot2docker.io/)
https://www.docker.com/products/docker-toolbox  (also for MAC)

## Containers on Windows Server 2016 TP5
https://blogs.msdn.microsoft.com/jcorioland/2016/04/28/getting-started-with-containers-and-docker-on-windows-server-2016-technical-preview-5/  