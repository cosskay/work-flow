import redis

# Исходный сервер
SOURCE_HOST = "10.0.0.0"
SOURCE_PORT = 6379
SOURCE_PASSWORD = "T"
SOURCE_DB = 2

# Целевой сервер
TARGET_HOST = "10.0.0.1"
TARGET_PORT = 6379
TARGET_PASSWORD = "T"
TARGET_DB = 2

def migrate_keys(source_conn, target_conn):
    cursor = 0
    while True:
        # Получаем ключи из исходного сервера
        cursor, keys = source_conn.scan(cursor, count=1000)
        for key in keys:
            # Получаем данные ключа
            value = source_conn.dump(key)
            # Восстанавливаем данные на целевом сервере
            target_conn.restore(key, 0, value)
        if cursor == 0:
            break

def main():
    # Подключение к исходному серверу
    source_conn = redis.StrictRedis(
        host=SOURCE_HOST,
        port=SOURCE_PORT,
        password=SOURCE_PASSWORD,
        db=SOURCE_DB
    )
    
    # Подключение к целевому серверу
    target_conn = redis.StrictRedis(
        host=TARGET_HOST,
        port=TARGET_PORT,
        password=TARGET_PASSWORD,
        db=TARGET_DB
    )
    
    # Перенос ключей
    migrate_keys(source_conn, target_conn)
    print("Миграция ключей завершена.")

if __name__ == "__main__":
    main()

