<!-- TOC -->

- [Docs](#docs)
- [Objects](#objects)
    - [namespaces](#namespaces)
- [kubectl](#kubectl)
- [Tutorial](#tutorial)
- [yaml](#yaml)
- [Verbosity](#verbosity)
- [minikube](#minikube)
    - [KVM](#kvm)
- [kops](#kops)

<!-- /TOC -->

# Docs
https://kubernetes.io/docs/setup/pick-right-solution/#table-of-solutions

https://kubernetes.io/docs/reference/kubectl/cheatsheet/

https://kubernetes.io/docs/reference/kubectl/docker-cli-to-kubectl/

kubectl run --image=nginx nginx-app --port=80 --env="DOMAIN=cluster"
kubectl expose deployment nginx-app --port=80 --name=nginx-http

# Objects
https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/

persistent entities  
All objects in REST API are identified by a Name(such as /api/v1/pods/some-name) and a UID.  
For non-unique user-provided attributes, Kubernetes provides labels and annotations.

## namespaces
multiple virtual clusters backed by the same physical cluster

    kubectl get namespaces

    NAME             STATUS    AGE
    default          Active    59d
    ibm-cert-store   Active    59d
    ibm-system       Active    59d
    kube-public      Active    59d
    kube-system      Active    59d

    default: for objects with no other namespace
    kube-system: created by the Kubernetes system
    kube-public: readable by all users. reserved for cluster usage, in case that some resources should be visible and readable publicly throughout the whole cluster. The public aspect of this namespace is only a convention, not a requirement

    kubectl --namespace=default get pods

# kubectl
https://kubernetes.io/docs/tasks/tools/install-kubectl/

    curl -LO https://storage.googleapis.com/kubernetes-release/release/$( \
        curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt \
        )/bin/linux/amd64/kubectl
    chmod +x kubectl && mv kubectl /usr/local/bin/

    sudo snap install kubectl --classic

    kubectl get nodes
    kubectl proxy --address='0.0.0.0' --accept-hosts='.*' --port=8080
    kubectl proxy --address=$IP_Private --accept-hosts='^.*$' # http://...:8080/ui

# Tutorial
    kubectl run nginx --image=nginx
    kubectl create deployment nginx --image nginx   # do the same thing as above

    kubectl expose deployment/nginx --name=nginx --type=NodePort --port=80 --target-port=80
    kubectl describe services nginx

    kubectl run hello-world --replicas=2 \
        --labels="run=load-balancer-example" \
        --image=gcr.io/google-samples/node-hello:1.0  \
        --port=8080

    kubectl get deployments hello-world
    kubectl describe deployments hello-world

    kubectl get replicasets
    kubectl describe replicasets

    kubectl expose deployment hello-world --type=LoadBalancer --name=my-service
    kubectl describe services my-service

    kubectl get services

# yaml

    kubectl create -f nginx.yaml
    kubectl replace -f nginx.yaml   # updates from another source will be lost
    kubectl delete -f nginx.yaml -f redis.yaml

`kubectl apply` supports multiple writers to the same object.

    kubectl apply -f configs/
    kubectl apply -R -f configs/    # Recursively 

    kubectl get -f https://example.com/x.yaml -o yaml                   # print
    kubectl get <kind>/<name> -o yaml --export > <kind>_<name>.yaml     # export

syntax: https://kubernetes.io/docs/concepts/overview/object-management-kubectl/declarative-config/

# Verbosity
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

## KVM
https://github.com/kubernetes/minikube/blob/master/docs/drivers.md#kvm-driver

    sudo usermod -a -G libvirt $(whoami)
    newgrp libvirt
    minikube config set vm-driver kvm

https://github.com/dhiltgen/docker-machine-kvm
https://github.com/docker/machine/releases

# kops
https://github.com/kubernetes/kops#linux  
kubectl for clusters  
