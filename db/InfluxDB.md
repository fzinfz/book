<!-- TOC -->

- [Data Format](#data-format)
- [Client](#client)
  - [cli](#cli)
  - [Python](#python)
- [Flux Query](#flux-query)
  - [difference()](#difference)

<!-- /TOC -->

# Data Format

    <measurement>[,<tag-key>=<tag-value>...] \
    <field-key>=<field-value>[,<field2-key>=<field2-value>...] \
    [unix-nano-timestamp]

# Client
## cli
https://docs.influxdata.com/influxdb/cloud/reference/cli/influx/#credential-precedence

    for c in version config ; do docker exec -it influxdb influx $c ; done
    docker exec -it influxdb influx bucket list --org $INFLUXDB_ORG --token $INFLUXDB_TOKEN
    

## Python
https://docs.influxdata.com/influxdb/cloud/tools/client-libraries/python/  
https://github.com/influxdata/influxdb-client-python#pip-install  

# Flux Query
https://docs.influxdata.com/influxdb/v2.0/query-data/flux/

## difference()
https://docs.influxdata.com/influxdb/v2.0/reference/flux/stdlib/built-in/transformations/difference/
