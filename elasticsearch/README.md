## Проверить статус кластера
```
curl -X GET "localhost:9200/_cluster/health?pretty"
```
## Удалить реплику индекса 
```
curl -X PUT "localhost:9200/your_index_name/_settings" -H 'Content-Type: application/json' -d'
{
  "index": {
    "number_of_replicas": 0
  }
}
'

```

# Backup 

## Для работы с дисками NFS ебходимо удостоверится что на всех нодах кластера user id и group id совпадают
```
cp -p /etc/passwd /etc/passwd.bkp
cp -p /etc/group /etc/group.bkp
id elasticsearch 
groupmod -g 993 elasticsearch
usermod -u 994 -g 993 elasticsearch
id elasticsearch
```
##  Назначить папку для  бэкапа Elasticsearch 
```
curl -XPUT 'http://localhost:9200/_snapshot/repository' -H 'Content-Type: application/json' -d '{"type": "fs","settings": {"location": "repository","compress": true}}'
```
## Назначить папку для файлов восстановленых из  бэкапа Elasticsearch 
```
curl -XPUT 'http://localhost:9200/_snapshot/recovery' -H 'Content-Type: application/json' -d '{"type": "fs","settings": {"location": "recovery","compress": true}}'
```
## Проверка  выполненых действий 
```
curl -XPOST "http://localhost:9200/_snapshot/backup/_verify
curl -XGET "http://localhost:9200/_snapshot/_all?pretty"
```
## Recovery
```
curl -XPOST http://localhost:9200/_snapshot/backup/_restore?pretty
``` 
## Просмотр snapshot 
```
http://localhost:9200/_snapshot/repository/nlog-snap-2021.03.15/_status?pretty
```
##  Задание  создания snapshot
```
PUT _slm/policy/snapshots-everyday
{
  "name": "<snapshots-everyday-{now/d}>",
  "schedule": "0 30 1 * * ?",
  "repository": "repository",
  "config": {
    "indices": []
  },
  "retention": {
    "expire_after": "2d"
  }
}

```

![Elasticsearch](https://img.shields.io/badge/Elasticsearch-8.9.0-yellow)