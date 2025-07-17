### Создание токена в S3
[![Shell Script](https://img.shields.io/badge/language-bash-blue?logo=gnu-bash)](https://www.gnu.org/software/bash/)
[![Security](https://img.shields.io/badge/security-hardened-critical?logo=linux)](https://github.com/topics/security)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

Описание команд radosgw-admin для Ceph RGW
В этой статье представлен разбор ключевых команд `radosgw-admin`, используемых для управления пользователями и квотами в Ceph Object Gateway (RGW) в рамках кластера Ceph.
## 1. Создание пользователя
``` bash
radosgw-admin --cluster server-ceph-tst user create --uid sys_digital-internet --display-name="sys_digital-internet DIGITALBNK-17488" --email="email@email.com"
```
Описание:
 - Создаёт нового пользователя S3 в Ceph RGW.
 - Может использоваться для инициализации сервисных или технических учётных записей.
# Параметры:
	•	`--cluster server-ceph-tst` — указывает кластер Ceph, к которому применяется команда.
	•	`user create` — указывает на создание нового пользователя.
	•	`--uid sys_digital-internet` — уникальный идентификатор пользователя (User ID).
	•	`--display-name="..."` — отображаемое имя пользователя. Часто используется для понятной идентификации учётной записи.
	•	`--email="..."` — электронная почта пользователя.
## 2. Включение квоты для пользователя
``` bash
radosgw-admin --cluster server-ceph-tst quota enable --quota-scope=user --uid sys_digital-internet
```
Описание:
 - Включает квотирование (ограничения) для указанного пользователя на уровне пользователя.
Параметры:
	•	`quota enable` — команда для включения механизма квот.
	•	`--quota-scope=user` — определяет область применения квоты (на пользователя).
	•	`--uid sys_digital-internet` — идентификатор пользователя, для которого включается квота.
## 3. Настройка квоты по объёму
``` bash
radosgw-admin --cluster server-ceph-tst quota set --max-size=1G --quota-scope=user --uid sys_digital-internet
```
Описание:
 - Устанавливает максимальный объём данных, который может быть размещён пользователем, на уровне пользователя.
Параметры:
	•	`quota set` — команда для задания параметров квоты.
	•	`--max-size=1G` — максимальный размер данных для пользователя (здесь — 1 гигабайт).
	•	`--quota-scope=user` — область действия квоты (на пользователя).
	•	`--uid sys_digital-internet` — на какого пользователя распространяется ограничение.
## 4. Получение информации о пользователе
``` bash
radosgw-admin --cluster server-ceph-tst user info --uid sys_digital-internet
```
Описание:
 - Получает детальную информацию о пользователе, включая статус, параметры доступа, сроки, ключи и квоты.
Параметры:
	•	`user info` — команда для получения информации о пользователе.
	•	`--uid sys_digital-internet` — идентификатор пользователя, информацию о котором требуется вывести.
