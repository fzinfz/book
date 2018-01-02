<!-- TOC -->

- [Kubernetes](#kubernetes)
- [Public Access](#public-access)
- [kubectl](#kubectl)
    - [verbose](#verbose)
- [minikube](#minikube)
        - [KVM](#kvm)
- [kops](#kops)
- [IBM](#ibm)

<!-- /TOC -->

# Kubernetes
https://kubernetes.io/docs/setup/pick-right-solution/#table-of-solutions

https://kubernetes.io/docs/reference/kubectl/cheatsheet/

# Public Access
![](https://console.bluemix.net/docs/api/content/containers/images/networkingdt.png?lang=en)

# kubectl
https://kubernetes.io/docs/tasks/tools/install-kubectl/

    curl -LO https://storage.googleapis.com/kubernetes-release/release/$( \
        curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt \
        )/bin/linux/amd64/kubectl
    chmod +x kubectl && mv kubectl /usr/local/bin/

    sudo snap install kubectl --classic

## verbose
|Verbosity|Description|
|---|---|
|--v=0|Generally useful for this to ALWAYS be visible to an operator.|
|--v=1|A reasonable default log level if you don’t want verbosity.|
|--v=2|Useful steady state information about the service and important log messages that may correlate to significant changes in the system. This is the recommended default log level for most systems.|
|--v=3|Extended information about changes.|
|--v=4|Debug level verbosity.|
|--v=6|Display requested resources.|
|--v=7|Display HTTP request headers.|
|--v=8|Display HTTP request contents.|

# minikube
https://github.com/kubernetes/minikube

    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    chmod +x minikube kubectl && sudo mv minikube /usr/local/bin/

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

# IBM
https://console.bluemix.net/containers-kubernetes/home/clusters

    bx plugin list
    bx plugin install container-service -r Bluemix

    bx cs region
    bx cs region-set eu-de

    bx cs clusters
    bx cs cluster-config mycluster

    kubectl get nodes
    kubectl proxy --address=$IP_Private --accept-hosts='^.*$' \
        --port=8080  # http://...:8080/ui