## Установка acme
```
git clone https://github.com/acmesh-official/acme.sh.git

cd ./acme.sh

./acme.sh --install -m my@muemail.ru

```

## Запрос сертификата 
```
./acme.sh --issue  -d mysite.ru --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please --server letsencrypt --force
...
.... Domain: '_acme-challenge.mysite.ru'
.... TXT value: 'pxG4i9AOm-Gv08xPRt5dBJEpwq2ConKxKcl7HAaWdiU'

```

## Добовляем txt запись в dns запись домена 

## Запускаем проверку txt записи 
```
./acme.sh --renew -d mysite.ru --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please --server letsencrypt --force
```  

## Получаем сертифкаты для домена . Если  хостинг не позволяет подключится к сервису letsencrypt
