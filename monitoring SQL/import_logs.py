import psycopg2
import json
import logging
from datetime import datetime

# Настройка логирования
with open("config.json", "r") as f:
    config = json.load(f)

logging.basicConfig(
    filename=config["log_file"],
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

# Подключение к PostgreSQL
try:
    conn = psycopg2.connect(
        dbname=config["dbname"],
        user=config["user"],
        password=config["password"],
        host=config["host"]
    )
    cursor = conn.cursor()
    logging.info("Подключение к базе данных успешно установлено.")
except Exception as e:
    logging.error(f"Ошибка подключения к базе данных: {e}")
    exit(1)

# Функция для импорта строки лога
def import_log_line(line):
    try:
        parts = line.split()
        timestamp = datetime.strptime(parts[3][1:], "%d/%b/%Y:%H:%M:%S")
        method = parts[5][1:]
        url = parts[6]
        status_code = int(parts[8])
        response_time = float(parts[-1])
        client_ip = parts[0]

        query = """
        INSERT INTO nginx_logs (timestamp, status_code, response_time, 
        request_method, url, client_ip) 
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (timestamp, status_code, response_time, 
                               method, url, client_ip))
        conn.commit()
        logging.info(f"Лог успешно импортирован: {line.strip()}")
    except Exception as e:
        logging.error(f"Ошибка при импорте строки: {e}")

# Чтение логов и импорт
try:
    with open("/var/log/nginx/access.log") as f:
        for line in f:
            import_log_line(line)
except FileNotFoundError as e:
    logging.error(f"Файл логов не найден: {e}")
except Exception as e:
    logging.error(f"Ошибка при чтении файла: {e}")

# Завершение работы
cursor.close()
conn.close()
logging.info("Импорт логов завершен.")
