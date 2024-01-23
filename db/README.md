<!-- TOC -->

- [Couchbase vs CouchDB](#couchbase-vs-couchdb)
- [API Query](#api-query)
- [key-value](#key-value)
- [Time Series DBs](#time-series-dbs)
- [TimescaleDB](#timescaledb)
- [Riak TS](#riak-ts)
- [Firebase](#firebase)
- [Supabase](#supabase)

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

# key-value
https://github.com/dgraph-io/badger

# Time Series DBs
Why relational database instead of NoSQL: 
https://blog.timescale.com/time-series-data-why-and-how-to-use-a-relational-database-instead-of-nosql-d0cd6975e87c

Elastic, InfluxDB, MongoDB, Cassandra, Couchbase, Graphite, Prometheus, ClickHouse, OpenTSDB, DalmatinerDB, KairosDB, RiakTS.

# TimescaleDB
https://github.com/timescale/timescaledb  
packaged as a PostgreSQL extension

http://docs.timescale.com/v0.8/getting-started/installation/linux/installation-docker

    docker run -d --name timescaledb -p 5432:5432 timescale/timescaledb

https://blog.timescale.com/when-boring-is-awesome-building-a-scalable-time-series-database-on-postgresql-2900ea453ee2

http://docs.timescale.com/v0.8/getting-started/creating-hypertables

    CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;

    SELECT create_hypertable('conditions', 'time');
    -- backgroud:
    CREATE INDEX conditions_time_idx
        ON public.conditions USING btree
        ("time" DESC)
        TABLESPACE pg_default;

    -- additionally partition the data on another
    --   dimension (what we call 'space partitioning').
    -- E.g., to partition `location` into 4 partitions:
    SELECT create_hypertable('conditions', 'time', 'location', 4);

    SELECT time_bucket('5 minutes', time) AS time_range,
        location, COUNT(*),
        MAX(temperature) AS max_temp,
        MAX(humidity) AS max_hum
    FROM conditions
    WHERE time > NOW() - interval '3 hours'
    GROUP BY time_range, location
    ORDER BY time_range DESC, max_temp DESC;

        time_range       | location | count | max_temp | max_hum 
    ------------------------+----------+-------+----------+---------
    2018-02-23 17:00:00+00 | office   |     3 |       70 |      50
    2018-02-23 16:35:00+00 | garage   |     1 |       77 |    65.2
    2018-02-23 16:35:00+00 | office   |     2 |     70.1 |    50.1
    2018-02-23 16:35:00+00 | basement |     1 |     66.5 |      60
    2018-02-23 16:25:00+00 | office   |     1 |       70 |      50
    (5 rows)

# Riak TS
http://docs.basho.com/riak/ts/  
Riak TS is a distributed NoSQL key/value store optimized for time series data. 

# Firebase
Realtime NoSQL: https://firebase.google.com/pricing

# Supabase
Firebase alternative, PostgreSQL
- OSS: https://github.com/supabase/supabase
- https://supabase.com/pricing