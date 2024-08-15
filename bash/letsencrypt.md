## Установка acme client 
```
git clone https://github.com/acmesh-official/acme.sh.git

cd ./acme.sh

./acme.sh --install -m my@muemail.ru

```

## Запрос сертификата   acme-challenge
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

# Получаем сертификат с помощью api  acme-challenge
## Установка acme client
```
$git clone https://github.com/acmesh-official/acme.sh.git
$cd ./acme.sh
$./acme.sh --install -m my@email.ru
$ alias acme.sh=~/.acme.sh/acme.sh
```
## Запрос сертификата  через api  AWS по умолчанию используется server zerossl 
```
$export  AWS_ACCESS_KEY
$export  AWS_SECRET_ACCESS_KEY
acme.sh  --issue  -d 'domen.ru' -d '*.domen.ru' --dns dns_aws --server letsencrypt --force
```
## получаем сертифкат wildcard для домена domen.ru

