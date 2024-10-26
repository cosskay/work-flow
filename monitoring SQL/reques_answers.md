## Количество запросов по статус-коду:

```
SELECT status_code, COUNT(*) 
FROM nginx_logs 
GROUP BY status_code 
ORDER BY COUNT(*) DESC;
```

## Запросы с наибольшим временем ответа:

```
SELECT * 
FROM nginx_logs 
ORDER BY response_time DESC 
LIMIT 10;
```
## IP-адреса с наибольшим количеством запросов:
```
SELECT client_ip, COUNT(*) 
FROM nginx_logs 
GROUP BY client_ip 
ORDER BY COUNT(*) DESC 
LIMIT 10;

```
