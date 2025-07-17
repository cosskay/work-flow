## Установка предварительного ПО
[![Shell Script](https://img.shields.io/badge/language-bash-blue?logo=gnu-bash)](https://www.gnu.org/software/bash/)
[![Security](https://img.shields.io/badge/security-hardened-critical?logo=linux)](https://github.com/topics/security)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
```
yum info redhat-lsb
yum install redhat-lsb
yum info pcsc-lite
yum install pcsc-lite
```

## Установка ПО КриптоПро Stunnel
```
rpm -i lsb-cprocsp-base-4.0.9956-5.noarch.rpm
rpm -i ./lsb-cprocsp-base-4.0.9956-5.noarch.rpm
rpm -i lsb-cprocsp-rdr-64-4.0.9956-5.x86_64.rpm
rpm -i lsb-cprocsp-rdr-ancud-64-4.0.9956-5.x86_64.rpm
rpm -i lsb-cprocsp-capilite-64-4.0.9956-5.x86_64.rpm
rpm -i lsb-cprocsp-kc1-64-4.0.9956-5.x86_64.rpm
rpm -i lsb-cprocsp-capilite-64-4.0.9956-5.x86_64.rpm
rpm -i cprocsp-stunnel-64-4.0.9956-5.x86_64.rpm
```

## Скачать и установить УЦ сертификат с http://cryptopro.ru/certsrv
```
/opt/cprocsp/bin/amd64/certmgr -inst -store root -file /etc/stunnel/cert/test-ca.crt
```

## Генерация серттивикатов (сервера и клиента) для сервера
```
cryptcp -creatcert -provtype 81 -rdn 'CN={HOSTNAME}' -cont '\\.\HDIMAGE\server' -certusage 1.3.6.1.5.5.7.3.1  -ku -du -ex -ca http://cryptopro.ru/certsrv
cryptcp -creatcert -provtype 81 -rdn 'CN={HOSTNAME}' -cont '\\.\HDIMAGE\client' -certusage 1.3.6.1.5.5.7.3.2  -ku -du -ex -ca http://cryptopro.ru/certsrv
```
## Экспортир сертификата в формат  DER
```
certmgr -export -dest /etc/stunnel/cert/server.cer -cont 'HDIMAGE\\server.000\7YT4E'
certmgr -export -dest /etc/stunnel/cert/client.cer -cont 'HDIMAGE\\clientap.000\3EW43'
```
## Установите личный сертификат
```
certmgr -inst -cont 'HDIMAGE\\server.000\7YT4E'
certmgr -inst -cont 'HDIMAGE\\client.000\3EW43'
```

## Скопировать сертификат в формате der и установить в TrustedUsers.
```
certmgr -inst -store TrustedUsers -file /etc/stunnel/cert/clientT.cer
```
## Управление службой 
```
systemctl status stunnel
```

##  Имена контейнеров используются для установки личных сертификатов.

###    Считыватель HDIMAGE размещается в /var/opt/cprocsp/keys/username/ 

## Для удобства использования утилит КриптоПро создадим на них символьные ссылки, для этого выполните:
```
ln -s /opt/cprocsp/bin/amd64/certmgr /usr/bin/certmgr
ln -s /opt/cprocsp/bin/amd64/csptest /usr/bin/csptest
ln -s /opt/cprocsp/sbin/amd64/cpconfig /usr/bin/cpconfig
```
##   Просмотр версии КриптоПро:
```
csptest -enum -info
```
## Проверка лицензии:
```
cpconfig -license -view
```
##  Для установки лицензии выполните (с правами root):
```
cpconfig -license -set <серийный_номер>
```
## Проверить наличие доступных контейнеров:
```
csptest -keyset -enum_cont -fqcn -verifyc | iconv -f cp1251  
```
## Просмотр подробной информации о контейнере:
```
csptest -keyset -container '\\.\HDIMAGE\server' -info
```
## Перечисление контейнеров компьютера:
```
csptest -keyset -enum_cont -verifycontext -fqcn -machinekeys
```
## Удалить пин код с контейнера
 ```
 Удаление  пин кода через изенения пин кода csptest -passwd -change '' -cont 'HDIMAGE\\11077469.00c\9192' -passwd 12345678
```
## Установка сертификата без привязки к ключам:
```
certmgr -inst -file cert_server.cer
```
## Установка сертификата с токена (в конце команды указывается контейнер)
```
/opt/cprocsp/bin/amd64/certmgr -inst -store uMy -cont '\\.\HDMI\\SERVER...'
```
## Установка в хранилище КриптоПро:
```
certmgr -inst -store uRoot -file <название-файла>.cer
```
## Установка в хранилище ПК:
```
certmgr -inst -store mRoot -file <название-файла>cer
```
## Установка списка отозванных сертификатов crl:
```
certmgr -inst -crl -file <название-файла>.crl
```
## Установка сертификатов pfx
```
certmgr -inst -store uMy -pfx -pin <пинкод> -file 'server.pfx'
```
## Просмотр установленных сертификатов:
```
certmgr -list
```
##  Просмотр сертификатов в контейнере:
```
certmgr -list -container '\\.\Aladdin R.D. JaCarta 00 00\server'
```
## Просмотр промежуточных сертификатов:
```
certmgr -list -store uca
```
## Удаление сертификатов
```
certmgr -delete -store uMy
```

## Сброс триал КриптоПро
```
удаляем в реестре ссылки на параметры 
4BE57065-DC50-4239-8E32-11FABAF5ECF5
C8B655BB-28A0-4BB6-BDE1-D0826457B2DF
инсталляция CSPSetup, выбирая "Исправить"
```
