<!-- TOC -->

- [Dash - Python](#dash---python)
- [Superset vs Redash vs Metabase](#superset-vs-redash-vs-metabase)
- [Apache Superset (Caravel/Panoramix)](#apache-superset-caravelpanoramix)
- [Redash](#redash)
- [ELK](#elk)
    - [My `docker run` scripts](#my-docker-run-scripts)
    - [Snapshot And Restore](#snapshot-and-restore)
        - [Backup](#backup)
        - [Check](#check)
- [ETL](#etl)
    - [kettle -JAVA](#kettle--java)
- [Excel](#excel)
    - [.Net](#net)
- [Word](#word)

<!-- /TOC -->
# Dash - Python
https://github.com/plotly/dash

# Superset vs Redash vs Metabase
https://www.pervasivecomputing.net/data-analytics/superset-vs-redash-vs-metabase

# Apache Superset (Caravel/Panoramix)
https://github.com/apache/incubator-superset
![](https://cloud.githubusercontent.com/assets/130878/20371438/a703a2a0-ac19-11e6-80c4-00a47c2eb644.gif)

# Redash 
https://github.com/getredash/redash
![](https://cloud.githubusercontent.com/assets/71468/17391289/8e83878e-5a1d-11e6-8938-af9054a33b19.gif)

# ELK
## My `docker run` scripts
https://github.com/fzinfz/docker-images/

## Snapshot And Restore
https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-snapshots.html

### Backup
```
PUT /_snapshot/bak_1
{
   "type": "fs",
   "settings": {
       "compress" : true,
       "location": "/usr/share/elasticsearch/data/backup"
   }
}

PUT /_snapshot/bak_1/snapshot_1?wait_for_completion=true
```

### Check
```
GET /_snapshot/bak_1
```

# ETL
## kettle -JAVA
https://github.com/pentaho/pentaho-kettle

# Excel
https://docs.wso2.com/display/DSS301/Excel+Sample

## .Net
https://github.com/tonyqus/npoi  
https://github.com/JanKallman/EPPlus/wiki/Getting-Started

# Word
https://github.com/xceedsoftware/DocX