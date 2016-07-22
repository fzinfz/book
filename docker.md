# Install
## Linux
https://docs.docker.com/engine/getstarted/linux_install_help/  
kernel must be 3.10 at minimum, which CentOS 7 runs.
```
sudo yum install docker-engine

$ curl -fsSL https://get.docker.com/ | sh
```
### CentOS
https://docs.docker.com/engine/installation/linux/centos/

```
$ sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

sudo service docker start
sudo chkconfig docker on
```

## Windows 
### [Linux based](boot2docker.io)
https://docs.docker.com/docker-for-windows/  
The current version of Docker for Windows runs on 64bit Windows 10 Pro, Enterprise and Education (1511 November update, Build 10586 or later). 

https://docs.docker.com/engine/installation/windows/

https://www.docker.com/products/docker-toolbox  (also for MAC)

#### Connect mirror on boot2docker
```
docker-machine ssh default 

echo EXTRA_ARGS="--registry-mirror=https://docker.mirrors.ustc.edu.cn"  >>  /var/lib/boot2docker/profile

docker login -u anonymouse -p anonymouse docker.mirrors.ustc.edu.cn 

```

### Windows container
https://msdn.microsoft.com/en-us/virtualization/windowscontainers/quick_start/quick_start_windows_server  

https://blogs.msdn.microsoft.com/jcorioland/2016/04/28/getting-started-with-containers-and-docker-on-windows-server-2016-technical-preview-5/  

```
Install-WindowsFeature containers
Restart-Computer -Force

New-Item -Type Directory -Path 'C:\Program Files\docker\'
Invoke-WebRequest https://aka.ms/tp5/b/dockerd -OutFile $env:ProgramFiles\docker\dockerd.exe -UseBasicParsing
Invoke-WebRequest https://aka.ms/tp5/b/docker -OutFile $env:ProgramFiles\docker\docker.exe -UseBasicParsing

[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Docker", [EnvironmentVariableTarget]::Machine)

dockerd --register-service
Start-Service docker

Install-PackageProvider ContainerImage -Force
Install-ContainerImage -Name WindowsServerCore
Restart-Service docker
```

## Containers on Windows Server 2016 TP5


# Registry
## Deploying a registry server
https://github.com/docker/distribution/blob/master/docs/deploying.md  
```
docker run -d -p 5000:5000 --restart=always --name registry registry:2
```
