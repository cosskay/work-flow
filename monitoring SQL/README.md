# Дашборд для анализа логов на SQL и PostgreSQL

## Описание
Этот проект позволяет анализировать логи Nginx с помощью PostgreSQL. Логи автоматически импортируются в базу данных, где их можно анализировать с помощью SQL-запросов. Также можно подключить Grafana для визуализации данных.

## Функционал
- Автоматический импорт логов в PostgreSQL.
- SQL-запросы для анализа логов.
- Опционально: графическая визуализация через Grafana.

## Установка и настройка
1. Установите PostgreSQL:
   ```bash
   sudo apt update
   sudo apt install postgresql postgresql-contrib
   ```
## Создайте виртуальное окружение и установите зависимости:
```python
python3 -m venv venv
source venv/bin/activate  # для Linux/macOS
venv\Scripts\activate  # для Windows
pip install -r requirements.txt

```
## Отредактируйте файл config.json с параметрами вашей базы данных.
``` json
{
    "dbname": "logs_db",
    "user": "log_user",
    "password": "password",
    "host": "localhost",
    "log_file": "import_logs.log"
}

```
## Создадание таблицы
2. Создайте базу данных и пользователя: 
```sql 
CREATE DATABASE logs_db;
CREATE USER log_user WITH ENCRYPTED PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE logs_db TO log_user;
```

## Склонируйте репозиторий
```bash
git clone https://github.com/your-username/log-analysis.git
cd log-analysis

```
## Использование
```python 
python import_logs.py

```

## SQL-запросы для анализа:

```bash 
SELECT * FROM nginx_logs;

```

## Настройка Grafana (опционально)
``` bash 
sudo apt-get install -y grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
```
## Подключите PostgreSQL в Grafana:

- Войдите в веб-интерфейс Grafana (http://localhost:3000).
- Перейдите в Configuration > Data Sources.
- Добавьте PostgreSQL с настройками подключения к базе logs_db.

Создайте дашборд для визуализации логов.

