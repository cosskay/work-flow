# перенос всех ключей с одного сервера keydb (redis) на другой

Для работы скрипта необходимо установить
```
pip install redis
```

Перед запуском необходимо изменить переменные 
```
SOURCE_HOST = "IP "           - адрес источника с которого необходимо перенести ключи
SOURCE_PORT = 6379            - порт сервиса 
SOURCE_PASSWORD = "PASSWORD"  - пароль для подключения к  keydb 
SOURCE_DB = 2                 - номер базы данных 

TARGET_HOST = "IP"            - адрес назначения  куда переносятся ключи 
TARGET_PORT = 6379            - порт сервиса 
TARGET_PASSWORD = "PASSWORD"  - пароль для подключения к keydb (redis)
TARGET_DB = 2                 -  номер  базы данных 
``` 

###### скорость переноса данных ~ 20 мин  10.000 keys

![KeyDB](https://img.shields.io/badge/KeyDB-v6.3.1-orange)