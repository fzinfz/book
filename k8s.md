<!-- TOC -->

- [Kubernetes](#kubernetes)
    - [Minikube](#minikube)
        - [KVM](#kvm)
- [kops](#kops)

<!-- /TOC -->

# Kubernetes
http://kubernetes.io/docs/getting-started-guides/

## Minikube
https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-with-snap-on-ubuntu
    sudo snap install kubectl --classic

https://github.com/kubernetes/minikube
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
    && chmod +x minikube \
    && sudo mv minikube /usr/local/bin/    

### KVM
https://github.com/kubernetes/minikube/blob/master/docs/drivers.md#kvm-driver
    sudo usermod -a -G libvirt $(whoami)
    newgrp libvirt
    minikube config set vm-driver kvm

https://github.com/dhiltgen/docker-machine-kvm
https://github.com/docker/machine/releases

# kops
https://github.com/kubernetes/kops#linux  
kubectl for clusters  