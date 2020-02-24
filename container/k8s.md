<!-- TOC -->

- [Docs](#docs)
- [Objects](#objects)
    - [namespaces](#namespaces)
- [controllers](#controllers)
    - [ReplicaSet](#replicaset)
    - [Replication Controller](#replication-controller)
    - [Deployment controller](#deployment-controller)
    - [StatefulSet](#statefulset)
    - [DaemonSet](#daemonset)
    - [Job & CronJob](#job--cronjob)
- [kubectl](#kubectl)
- [dashboard admin](#dashboard-admin)
- [expose](#expose)
- [token](#token)
- [Tutorial](#tutorial)
- [yaml](#yaml)
    - [syntax](#syntax)
        - [env](#env)
        - [Command and Arguments](#command-and-arguments)
- [Verbosity](#verbosity)
- [minikube](#minikube)
    - [Bare metal](#bare-metal)
    - [KVM](#kvm)
- [kops](#kops)
- [Create a Cluster](#create-a-cluster)
- [Persistent Volumes](#persistent-volumes)
- [helm - package manager](#helm---package-manager)
    - [WebUI](#webui)
    - [Hub](#hub)

<!-- /TOC -->

# Docs
https://kubernetes.io/docs/setup/pick-right-solution/#table-of-solutions

https://kubernetes.io/docs/reference/kubectl/cheatsheet/

https://kubernetes.io/docs/reference/kubectl/docker-cli-to-kubectl/

    kubectl run --image=nginx nginx-app --port=80 --env="DOMAIN=cluster" # deployment "nginx-app" created
    kubectl expose deployment nginx-app --port=80 --name=nginx-http      # service "nginx-http" exposed
    kubectl exec nginx-app-5jyvm -- cat /etc/hostname

    kubectl get deployment
    kubectl get pods -a
    kubectl logs <pod_name>
    kubectl version --short

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

# controllers
## ReplicaSet
ReplicaSet is the next-generation Replication Controller.  
ReplicaSet supports the new set-based selector requirements

    kubectl get pods -l 'environment,environment notin (frontend)'

## Replication Controller
only supports equality-based selector requirements.  

    kubectl get pods -l environment=production,tier=frontend

## Deployment controller
https://kubernetes.io/docs/concepts/workloads/controllers/deployment/  
provides declarative updates for Pods and ReplicaSets.

## StatefulSet
workload API object used to manage stateful applications.  
Unlike a Deployment, a StatefulSet maintains a sticky identity for each of their Pods.

    Stable, unique network identifiers.
    Stable, persistent storage.
    Ordered, graceful deployment and scaling.
    Ordered, graceful deletion and termination.
    Ordered, automated rolling updates.

## DaemonSet
ensures that all (or some) Nodes run a copy of a Pod. 

## Job & CronJob
https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/

# kubectl
https://kubernetes.io/docs/tasks/tools/install-kubectl/

    curl -LO https://storage.googleapis.com/kubernetes-release/release/$( \
        curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt \
        )/bin/linux/amd64/kubectl
    chmod +x kubectl && mv kubectl /usr/local/bin/

    sudo snap install kubectl --classic

    kubectl get nodes
    export KUBECONFIG=/path/to/kube-config-mil01-mycluster.yml # 
    kubectl proxy --address='0.0.0.0' --accept-hosts='.*' --port=8080
    kubectl proxy --address=$IP_Private --accept-hosts='^.*$' # http://...:8080/ui

# dashboard admin
https://github.com/kubernetes/dashboard/wiki/Access-control#admin-privileges

# expose
https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/

    kubectl port-forward redis-master 6379:6379

`kubectl expose -h`

    pod (po), service (svc), replicationcontroller (rc), deployment (deploy), replicaset (rs)

    # Create a service for a replicated nginx, which serves on port 80 and connects to the containers on port 8000.
    kubectl expose rc nginx --port=80 --target-port=8000

    # Create a service for a replication controller identified by type and name specified in "nginx-controller.yaml",
    which serves on port 80 and connects to the containers on port 8000.
    kubectl expose -f nginx-controller.yaml --port=80 --target-port=8000

    # Create a service for a pod valid-pod, which serves on port 444 with the name "frontend"
    kubectl expose pod valid-pod --port=444 --name=frontend

    # Create a second service based on the above service, exposing the container port 8443 as port 443 with the name
    "nginx-https"
    kubectl expose service nginx --port=443 --target-port=8443 --name=nginx-https

    # Create a service for a replicated streaming application on port 4100 balancing UDP traffic and named 'video-stream'.
    kubectl expose rc streamer --port=4100 --protocol=udp --name=video-stream

    # Create a service for a replicated nginx using replica set, which serves on port 80 and connects to the containers on
    port 8000.
    kubectl expose rs nginx --port=80 --target-port=8000

    # Create a service for an nginx deployment, which serves on port 80 and connects to the containers on port 8000.
    kubectl expose deployment nginx --port=80 --target-port=8000

# token
    kubectl describe secret
    kubectl config view -o jsonpath='{.users[0].user.auth-provider.config.id-token}'

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
Release 1.8: `apps/v1beta1` -> `apps/v1beta2`; 1.9： -> `apps/v1`

    kubectl create -f nginx.yaml
    kubectl replace -f nginx.yaml   # updates from another source will be lost
    kubectl delete -f nginx.yaml -f redis.yaml

`kubectl apply` supports multiple writers to the same object.

    kubectl apply -f configs/
    kubectl apply -R -f configs/    # Recursively 

    kubectl get -f https://example.com/x.yaml -o yaml                   # print
    kubectl get <kind>/<name> -o yaml --export > <kind>_<name>.yaml     # export

## syntax
https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.9/
https://kubernetes.io/docs/concepts/overview/object-management-kubectl/declarative-config/

### env
https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/

### Command and Arguments
https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/

|Description|Docker field name|Kubernetes field name|
|---|---|---|
|The command run by the container|Entrypoint|command|
|The arguments passed to the command|Cmd|args|

    spec:
    containers:
    - name: command-demo-container
        image: debian
        command: ["printenv"]
        args: ["HOSTNAME", "KUBERNETES_PORT"]

        command:
        - sh
        - -c
        - while true; do sleep 1; done

Example： https://github.com/kubernetes/kubernetes/blob/master/examples/guestbook/all-in-one/guestbook-all-in-one.yaml

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
    curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.8.0/bin/linux/amd64/kubectl
    chmod +x minikube kubectl  && mv minikube kubectl /usr/local/bin/
    
## Bare metal
https://minikube.sigs.k8s.io/docs/start/linux/

    minikube start --vm-driver=none && minikube config set vm-driver none
    minikube logs

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

# Create a Cluster
https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/
https://kubernetes.io/docs/getting-started-guides/scratch/#designing-and-preparing

# Persistent Volumes
https://kubernetes.io/docs/concepts/storage/persistent-volumes/

    apiVersion: v1
    kind: PersistentVolume
    metadata:
    name: pv0003
    spec:
    capacity:
        storage: 5Gi
    volumeMode: Filesystem
    accessModes:
        - ReadWriteOnce
    persistentVolumeReclaimPolicy: Recycle
    storageClassName: slow
    mountOptions:
        - hard
        - nfsvers=4.1
    nfs:
        path: /tmp
        server: 172.17.0.2

|Volume Plugin|ReadWriteOnce|ReadOnlyMany|ReadWriteMany|
|---|---|---|---|
|AWSElasticBlockStore|✓|-|-|
|AzureFile|✓|✓|✓|
|AzureDisk|✓|-|-|
|CephFS|✓|✓|✓|
|Cinder|✓|-|-|
|FC|✓|✓|-|
|FlexVolume|✓|✓|-|
|Flocker|✓|-|-|
|GCEPersistentDisk|✓|✓|-|
|Glusterfs|✓|✓|✓|
|HostPath|✓|-|-|
|iSCSI|✓|✓|-|
|PhotonPersistentDisk|✓|-|-|
|Quobyte|✓|✓|✓|
|NFS|✓|✓|✓|
|RBD|✓|✓|-|
|VsphereVolume|✓|-|- (works when pods are collocated)|
|PortworxVolume|✓|-|✓|
|ScaleIO|✓|✓|-|
|StorageOS|✓|-|-|

# helm - package manager
https://docs.helm.sh/using_helm/#quickstart

## WebUI
https://github.com/kubernetes-helm/monocular

    helm repo add monocular https://kubernetes-helm.github.io/monocular
    helm install monocular/monocular
    kubectl get ingress

https://github.com/kubeapps/hub  
navigate and search Helm Charts.

## Hub
https://hub.kubeapps.com/