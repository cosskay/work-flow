## Отключите выделение сегментов
```
PUT _cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.enable": "primaries" 
  }
}
```
## Остановите несущественное индексирование и выполните синхронизированную очистку
```
curl -X POST "localhost:9200/_flush/synced?pretty" 
```
## Необходимо останавливать
```
curl -X POST "localhost:9200/_flush/synced?pretty" 
curl -X POST "localhost:9200/_ml/set_upgrade_mode?enabled=true&pretty" 
```
## Установка ПО 
```
sudo systemctl stop elasticsearch.service
rpm -Uvh elasticsearch-7.17.18-x86_64.rpm
systemctl daemon-reload
./elasticsearch-plugin install file:///mnt/mapper-size-7.17.18.zip
systemctl restart elasticsearch.service && systemctl status  elasticsearch.service
```
## После обновления включаем выделение сегментов
```
curl -X PUT "localhost:9200/_cluster/settings?pretty" -H 'Content-Type: application/json' -d'
{
  "persistent": {
    "cluster.routing.allocation.enable": null
  }
}
'
```
## Проверяем статус кластера
```
curl -X GET "localhost:9200/_cat/health?v=true&pretty" 
```

