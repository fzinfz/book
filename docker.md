# Docker on Windows
## Setting mirror
```
docker-machine ssh default 

echo EXTRA_ARGS="--registry-mirror=https://docker.mirrors.ustc.edu.cn"  >>  /var/lib/boot2docker/profile

docker login -u anonymouse -p anonymouse docker.mirrors.ustc.edu.cn 

```
## Containers on Windows Server 2016 TP5
https://blogs.msdn.microsoft.com/jcorioland/2016/04/28/getting-started-with-containers-and-docker-on-windows-server-2016-technical-preview-5/  