<!-- TOC -->

- [OSS](#oss)
- [IBM](#ibm)

<!-- /TOC -->

# OSS

| by-gemini | RabbitMQ | Apache RocketMQ | ZeroMQ ($\text{ØMQ}$) |
| :--- | :--- | :--- | :--- |
| **Architectural Model** | **Brokered** (Central Server) | **Brokered** (NameServer + Broker Cluster) | **Brokerless** (Networking Library) |
| **Primary Use Case** | General purpose messaging, Complex Routing, Task Queues (e.g., Celery) | High-volume, High-reliability, Transactional Messaging, E-commerce, Financial Systems. | High-speed/Low-latency messaging, Building custom, light-weight P2P communication. |
| **Messaging Paradigm** | Queue-based (Exchanges route to Queues) | Partitioned Queue-based (Topics) | Socket-based patterns (e.g., PUB/SUB, REQ/REP) |
| **Message Persistence** | Strong (Configurable to disk for durability) | Strong (Financial-grade reliability) | None by default (Messages are lost if no receiver is connected). |
| **Throughput & Latency** | Moderate Throughput, **Very Low Latency** | High Throughput, Low Latency (Optimized for scale) | **Extremely High Throughput** and **Lowest Latency** (due to brokerless design) |
| **Scalability** | Moderate (Clustering/Mirroring can add complexity/overhead) | High (Separate NameServer and Broker for easy horizontal scaling) | Excellent (Scales N-to-N by adding endpoints, though developer must manage topology) |
| **Message Routing** | **Most Flexible** (Uses Exchanges: Direct, Topic, Fanout, etc.) | Flexible (Topic and Tag-based routing) | Simple (Pattern-based: must be coded by application developer) |
| **Complexity** | Easier to set up and manage for standard use cases. | Moderate to High (More complex architecture with NameServer). | High (Requires developers to manage connection logic, fault-tolerance, and message loss). |
| **Implementation** | Erlang | Java | C++ (Language bindings for many languages) |

* https://github.com/rabbitmq | when you need a tried-and-true message broker with a focus on **flexible routing**, message reliability, and standard enterprise messaging patterns.
* https://github.com/apache/rocketmq | when you need **financial-grade reliability**, high throughput, and features like transactional messages, especially for large-scale distributed systems.
* https://github.com/zeromq | when you need the **fastest possible message transfer** between services and are willing to write the application-level logic for reliability, persistence, and complex routing yourself. It is not a broker, but a library.

# IBM

- client libraries: https://developer.ibm.com/articles/mq-downloads/
- 9.2.4: https://hub.docker.com/r/ibmcom/mq/

https://github.com/ibm-messaging/mq-container/blob/master/docs/usage.md

    docker run \
    --env LICENSE=accept \
    --env MQ_QMGR_NAME=QM1 \
    --publish 1414:1414 \
    --publish 9443:9443 \
    --detach \
    --volume qm1data:/mnt/mqm \
    icr.io/ibm-messaging/mq