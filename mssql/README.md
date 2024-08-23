## Зпросы для работы с MSSQL 

### Полезные ресурсы 

## https://whoisactive.com/docs/
## backup https://ola.hallengren.com

## Просмотр активных ссесий 
```
exec sp_WhoIsActive 
```

## Просмотреть  запросы которые загружают CPU
```
exec sp_WhoIsActive @sort_order = '[cpu]DESC'
```
