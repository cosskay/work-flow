## Установка postgresql 
```

```
## Создание супер  пользователя 
```
CREATE ROLE {superuser} WITH LOGIN PASSWORD '{password}';
ALTER ROLE {superuser} WITH SUPERUSER;

```
## Создание пользователя с правами мониторинга:
```
CREATE ROLE monitor_role WITH LOGIN PASSWORD '{password}';
GRANT pg_monitor TO monitor_role;
```
## Создание пользователя с правами только чтение: 
```
CREATE ROLE readonly_role WITH LOGIN PASSWORD '{password}';
```
-- Предоставление прав на чтение всем таблицам в базе данных
```
GRANT CONNECT ON DATABASE {your_database} TO readonly_role;
```
\c your_database
```
GRANT USAGE ON SCHEMA public TO readonly_role;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_role;
```
-- Настройка автоматического предоставления прав на новые таблицы
```
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly_role;
```
## Создание базы данных 
```
psql -U root
CREATE DATABASE {your_database_name}
OWNER root
ENCODING 'UTF8'
LC_COLLATE 'en_US.UTF-8'
LC_CTYPE 'en_US.UTF-8'
TEMPLATE template0;
```
## Мониторинг 
```
SELECT * FROM pg_stat_activity;
```

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue)