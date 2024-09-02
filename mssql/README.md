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
## Для пересоздания первичного ключа необходимо его удали , но при удалении
## возникает проблема так как есть ссылка на Foreign key .  Скрипт дает  сразу выдает запрос на создание и удлаение FK при пересоздании Primary Key . Необходимо заменить NAMETABLE на необходимую таблицу.
```
find_FK.sql
```
