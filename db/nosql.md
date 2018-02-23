<!-- TOC -->

- [Couchbase vs CouchDB](#couchbase-vs-couchdb)
- [API Query](#api-query)
- [Time-series](#time-series)
    - [TimescaleDB](#timescaledb)
    - [Riak TS](#riak-ts)

<!-- /TOC -->

# Couchbase vs CouchDB
https://www.couchbase.com/couchbase-vs-couchdb

|| Couchbase Server|Apache CouchDB|
|---|---|
|Topology|Distributed|Replicated|
|Automatic failover|Yes|No|
|Integrated cache|Yes|No|
|Memcached compatible|Yes|No|
|Query language|Yes, N1QL (SQL for JSON)|No|

# API Query
http://graphql.org/

# Time-series
## TimescaleDB
https://github.com/timescale/timescaledb  
packaged as a PostgreSQL extension

http://docs.timescale.com/v0.8/getting-started/installation/linux/installation-docker

    docker run -d --name timescaledb -p 5432:5432 timescale/timescaledb

https://blog.timescale.com/when-boring-is-awesome-building-a-scalable-time-series-database-on-postgresql-2900ea453ee2

Why relational database instead of NoSQL: 
https://blog.timescale.com/time-series-data-why-and-how-to-use-a-relational-database-instead-of-nosql-d0cd6975e87c

NoSQL databases include: Elastic, InfluxDB, MongoDB, Cassandra, Couchbase, Graphite, Prometheus, ClickHouse, OpenTSDB, DalmatinerDB, KairosDB, RiakTS.

## Riak TS
http://docs.basho.com/riak/ts/  
Riak TS is a distributed NoSQL key/value store optimized for time series data. 
