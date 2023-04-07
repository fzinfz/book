

https://hub.docker.com/r/ibmcom/mq/

https://github.com/ibm-messaging/mq-container/blob/master/docs/usage.md

    docker run \
    --env LICENSE=accept \
    --env MQ_QMGR_NAME=QM1 \
    --publish 172.16.0.7:1414:1414 \
    --publish 172.16.0.7:7443:9443 \
    --detach \
    ibmcom/mq