#!/bin/bash

# Настройки
LOG_FILE="/var/log/monitoring.log"
TELEGRAM_TOKEN="123456789:ABCDEF..."  # Токен Telegram-бота
CHAT_ID="12345678"  # Твой Chat ID

# Функция для логирования
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Функция для отправки уведомления в Telegram
send_telegram_notification() {
    MESSAGE="$1"
    curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
        -d chat_id="${CHAT_ID}" \
        -d text="${MESSAGE}" \
        -d parse_mode="HTML"
}

# Мониторинг Docker контейнеров
monitor_docker() {
    log_message "Проверка Docker контейнеров..."
    docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.RunningFor}}" >> "$LOG_FILE"

    # Проверка на использование ресурсов
    docker stats --no-stream >> "$LOG_FILE"

    # Очистка остановленных контейнеров и старых образов
    docker container prune -f
    docker image prune -f
}

# Мониторинг Kubernetes подов
monitor_kubernetes() {
    log_message "Проверка Kubernetes подов..."
    kubectl get pods -A --field-selector=status.phase!=Running -o wide >> "$LOG_FILE"

    # Проверка рестартов подов
    kubectl get pods -A | awk '$5 > 5 {print $0}' >> "$LOG_FILE"
}

# Основной блок выполнения
log_message "Запуск мониторинга..."
monitor_docker
monitor_kubernetes

# Отправка уведомления в Telegram при обнаружении проблем
if grep -q "Error\|CrashLoopBackOff" "$LOG_FILE"; then
    send_telegram_notification "❗️ Обнаружены проблемы! Проверьте логи: $LOG_FILE"
fi

log_message "Мониторинг завершен."
