<!-- TOC -->

- [Backup](#backup)
- [Check](#check)

<!-- /TOC -->

https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-snapshots.html

# Backup
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

# Check
```
GET /_snapshot/bak_1
```

