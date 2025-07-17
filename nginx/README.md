
# Установка и Настройка ACME для Управления Сертификатами
[![Shell Script](https://img.shields.io/badge/language-bash-blue?logo=gnu-bash)](https://www.gnu.org/software/bash/)
[![Security](https://img.shields.io/badge/security-hardened-critical?logo=linux)](https://github.com/topics/security)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

Этот документ описывает процесс установки и настройки ACME для получения SSL сертификатов с использованием Let's Encrypt и AWS Route 53 для DNS-валидации.

## Установка ACME

1. **Клонируйте репозиторий ACME:**

   Откройте терминал и выполните следующую команду для клонирования репозитория ACME:

``` sh
   git clone https://github.com/acmesh-official/acme.sh.git
```
## Перейдите в директорию с клонированным репозиторием:
``` sh 
cd ./acme.sh
```
## Установите ACME:

Выполните команду для установки ACME и указания вашего адреса электронной почты:
``` sh 
./acme.sh --install -m my@mail.com
```
## Создайте alias для команды acme.sh:
``` sh 
alias acme.sh=~/.acme.sh/acme.sh
```
## Установите переменные окружения для доступа к AWS:
``` sh 
export AWS_ACCESS_KEY_ID=<ваш_ключ>
export AWS_SECRET_ACCESS_KEY=<ваш_секретный_ключ>
```

## Получите сертификат:
``` sh 
acme.sh --issue -d domain.com -d *.domain.com --dns dns_aws --server letsencrypt --force

```

## Проверьте сертификат с помощью OpenSSL:
``` sh 
openssl x509 -in /etc/nginx/domain/domain.com.crt -text

```
## Дополнительные Ресурсы

- **[Документация ACME](https://github.com/acmesh-official/acme.sh)**  
  

- **[Документация Let's Encrypt](https://letsencrypt.org/docs/)**  


- **[Документация AWS Route 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html)**  


- **[OpenSSL Documentation](https://www.openssl.org/docs/)**  
 

- **[ACME.sh Wiki](https://github.com/acmesh-official/acme.sh/wiki)**  


- **[Let's Encrypt Community Support](https://community.letsencrypt.org/)**  




![Nginx](https://img.shields.io/badge/Nginx-1.26-green)