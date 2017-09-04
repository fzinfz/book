<!-- TOC -->

- [My `docker run` scripts](#my-docker-run-scripts)
- [Snapshot And Restore](#snapshot-and-restore)
    - [Backup](#backup)
    - [Check](#check)

<!-- /TOC -->
# My `docker run` scripts
https://github.com/fzinfz/docker-images/

# Snapshot And Restore
https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-snapshots.html

## Backup
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

## Check
```
GET /_snapshot/bak_1
```

