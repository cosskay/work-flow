# Certificate Generation Utility
[![Shell Script](https://img.shields.io/badge/language-bash-blue?logo=gnu-bash)](https://www.gnu.org/software/bash/)
[![Security](https://img.shields.io/badge/security-hardened-critical?logo=linux)](https://github.com/topics/security)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

Этот репозиторий содержит скрипт для генерации самоподписанных SSL-сертификатов с использованием OpenSSL. Скрипт использует внешний конфигурационный файл `config.cfg`, в котором задаются параметры сертификата.

## 📁 Содержимое

- `build_cert.sh` — основной Bash-скрипт генерации сертификата.
- `config.cfg` — конфигурационный файл с параметрами сертификата (CN, OU, O, C и пр.).

## 📋 Требования

- Unix-подобная ОС (Linux, macOS)
- OpenSSL
- Bash

## ⚙️ Настройка

1. Установите OpenSSL, если он не установлен:
    ```bash
    sudo apt install openssl  # Debian/Ubuntu
    sudo yum install openssl  # RHEL/CentOS
    brew install openssl      # macOS
    ```

2. Отредактируйте файл `config.cfg` с вашими данными:

    ```ini
    CN=example.com
    O=Example Company
    OU=IT Department
    C=RU
    ST=Moscow
    L=Moscow
    DAYS=365
    ```

    - `CN` — Common Name (например, домен сайта).
    - `O` — Организация.
    - `OU` — Подразделение.
    - `C` — Страна.
    - `ST` — Регион / область.
    - `L` — Город.
    - `DAYS` — Срок действия сертификата в днях.

## ▶️ Использование

1. Дайте права на выполнение скрипта:

    ```bash
    chmod +x build_cert.sh
    ```

2. Запустите скрипт:

    ```bash
    ./build_cert.sh
    ```

3. После выполнения будут созданы следующие файлы:

    - `certs/yourdomain.crt` — сертификат
    - `certs/yourdomain.key` — приватный ключ
    - `certs/yourdomain.csr` — запрос на подпись (если требуется)

## 🛠 Структура выходных файлов

По умолчанию все файлы создаются в подкаталоге `certs/`. Убедитесь, что он существует или будет создан автоматически скриптом.

## 🔐 Безопасность

- Приватный ключ (`*.key`) должен храниться в безопасном месте.
- Убедитесь, что к нему имеют доступ только авторизованные пользователи:
  
  ```bash
  chmod 600 certs/*.key
  ```
  ## 🛠 Примеры использования OpenSSL

Ниже приведены типовые команды для работы с сертификатами и ключами с помощью `openssl`.

### 🔍 Просмотр сертификатов

```bash
# Просмотреть содержимое PEM-сертификата (.crt, .pem)
openssl x509 -in cert.pem -noout -text

# Просмотреть информацию о CSR (запрос на сертификат)
openssl req -in request.csr -noout -text

# Просмотреть информацию о закрытом ключе
openssl rsa -in private.key -check

# Проверка совпадения ключа и сертификата
openssl x509 -noout -modulus -in cert.pem | openssl md5
openssl rsa -noout -modulus -in private.key | openssl md5
```
## Конвертация форматов сертификатов
``` bash 
# PEM → DER
openssl x509 -in cert.pem -outform der -out cert.der

# DER → PEM
openssl x509 -in cert.der -inform der -out cert.pem

# PEM (.crt + .key) → PKCS#12 (.p12)
openssl pkcs12 -export -out cert.p12 -inkey private.key -in cert.crt -certfile chain.crt

# P7B (.p7b, .spc) → PEM
openssl pkcs7 -print_certs -in cert.p7b -out cert.pem

# PEM → P7B
openssl crl2pkcs7 -nocrl -certfile cert.pem -out cert.p7b -certfile CA.crt
```
# Работа с Java KeyStore (через keytool + openssl)
``` bash 
# PKCS#12 (.p12) → JKS (с помощью keytool)
keytool -importkeystore -srckeystore cert.p12 -srcstoretype pkcs12 -destkeystore cert.jks -deststoretype JKS

# JKS → PKCS#12
keytool -importkeystore -srckeystore cert.jks -destkeystore cert.p12 -deststoretype PKCS12
```
#  Генерация и работа с ключами
``` bash 
# Генерация закрытого ключа RSA (2048 бит)
openssl genrsa -out private.key 2048

# Генерация публичного ключа из закрытого
openssl rsa -in private.key -pubout -out public.key

# Создание запроса на сертификат (CSR)
openssl req -new -key private.key -out request.csr

# Подпись сертификата самостоятельно (self-signed)
openssl x509 -req -days 365 -in request.csr -signkey private.key -out cert.crt
```
# Проверка соответствия и цепочки 
``` bash 
# Проверка соответствия ключа и сертификата
openssl x509 -noout -modulus -in cert.crt | openssl md5
openssl rsa -noout -modulus -in private.key | openssl md5

# Проверка цепочки сертификатов
openssl verify -CAfile chain.pem cert.pem
```
# Извлечение из p12
``` bash 
# Извлечь ключ и сертификат из PKCS#12 (.p12)
openssl pkcs12 -in cert.p12 -out cert.pem -nodes
```
# Проверить сертификат домена 
``` bash 
echo | openssl s_client -servername google.com -connect google.com:443 2>/dev/null | \
openssl x509 -noout -dates
```
