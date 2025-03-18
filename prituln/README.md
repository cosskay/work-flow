####### скрипт установки и конфигурации Prituln Ubuntu 18
Если  будет проблема с поднятием сервиса Prituln необходимо задать логин пароль в Mongo
``` bash 
mongo 
use admin
db.createUser({
  user: "pri",
  pwd: "Aa12345678",
  roles: [{ role: "root", db: "admin" }]
})
```
####### Редактируем строку подкулючение  в конфиге  /etc/pritunl.conf
``` bash 
"mongodb_uri": "mongodb://pri:Aa12345678@localhost:27017/pritunl?authSource=admin"
```
####### Рестарт служб 
```bash  
  systemctl restart pritunl
  systemctl restart mongod
```
###### Авторизация в web https://IP_SERVER  

``` bash 
pritunl default-password  // получаем логин пароль

```
###### Проверка запуска  
```bash  
 
 ss -tulnp | grep 27018
 ss -tulnp | grep 443

```
