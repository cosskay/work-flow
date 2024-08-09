#!/bin/bash

# Параметры Telegram бота
BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="YOUR_CHAT_ID"

# Функция для отправки сообщения в Telegram
send_telegram_message() {
    local success=$1
    local task_name=$2
    local log_message=$3
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    if [ "$success" -eq 1 ]; then
        local text="✅ Задание: ${task_name}\nВремя: ${timestamp}"
    else
        local text="❌ Задание: ${task_name}\nОшибка: ${log_message}\nВремя: ${timestamp}"
    fi

    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
        -d "chat_id=${CHAT_ID}" \
        -d "text=${text}" \
        -d "parse_mode=HTML"
}

# Функция для выполнения подскриптов
run_backup_script() {
    local script_name=$1
    local log_file=$2
    local task_name=$3
    
    bash "$script_name" > "$log_file" 2>&1
    if [ $? -eq 0 ]; then
        send_telegram_message 1 "$task_name"
    else
        send_telegram_message 0 "$task_name" "Ошибка при выполнении. Проверьте лог файл: $log_file"
    fi
}

# Параметры для резервного копирования
WAL_BACKUP_SCRIPT="/srv/wal_backup.sh"
DIFF_BACKUP_SCRIPT="/srv/diff_backup.sh"
FULL_BACKUP_SCRIPT="/ssv/full_backup.sh"

# Лог файлы
WAL_LOG_FILE="/mnt/backup/logs/wal_backup.log"
DIFF_LOG_FILE="/mnt/backup/logs/diff_backup.log"
FULL_LOG_FILE="/mnt/backup/logs/full_backup.log"

# Выполнение резервных копий
run_backup_script "$WAL_BACKUP_SCRIPT" "$WAL_LOG_FILE" "WAL Backup"
run_backup_script "$DIFF_BACKUP_SCRIPT" "$DIFF_LOG_FILE" "Дифференциальное резервное копирование"
run_backup_script "$FULL_BACKUP_SCRIPT" "$FULL_LOG_FILE" "Полное резервное копирование"

