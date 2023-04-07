
<!-- TOC -->

- [cli](#cli)
- [Container](#container)
- [external services](#external-services)

<!-- /TOC -->

# cli

    curl -fsSL https://clis.ng.bluemix.net/install/linux | sh

    docker run --name bluemix \
        -d --restart unless-stopped \
        --privileged --net host \
        reachlin/bluemix
    docker exec -it bluemix bash

https://console.bluemix.net/containers-kubernetes/home/clusters

    bx plugin list
    bx plugin install container-service -r Bluemix
    bx plugin update container-service -r Bluemix

    bx login -a https://api.eu-de.bluemix.net -sso

    bx cs region
    bx cs region-set eu-de

    bx cs clusters
    bx cs cluster-config mycluster

    bx cs workers mycluster # check public IP
    bx cs worker-update mycluster <node_id>

    BLUEMIX_TRACE=path/to/trace.log         # Append API request diagnostics to a log file
    BLUEMIX_API_KEY=api_key_value           # API key to use during login

# Container
https://dev-console.stage1.bluemix.net/docs/containers/cs_network_planning.html

    NodePort service (free and standard clusters)
    LoadBalancer service (standard clusters only)
    Ingress (standard clusters only)

![](https://dev-console.stage1.bluemix.net/docs/api/content/containers/images/networking.png?lang=en-US)

    bx cs cluster-get mycluster # Master URL

[k8s related](/container/k8s.md)

# external services

https://console.bluemix.net/docs/containers/cs_integrations.html#adding_cluster

    bx service list

    name                    service                  plan   bound apps   last operation
    Monitoring-tz           Monitoring               lite                create succeeded
    Visual Recognition-8p   watson_vision_combined   free                create succeeded
