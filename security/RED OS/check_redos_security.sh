#!/bin/bash

set -e

OS_INFO=$(grep -E '^NAME|^VERSION_ID' /etc/os-release)
echo "📦 ОС: $OS_INFO"
echo

# Проверка, что ОС — РЕД ОС 7.x
if ! grep -q 'RED OS' <<< "$OS_INFO" || ! grep -q '7' <<< "$OS_INFO"; then
    echo "❌ Скрипт предназначен для запуска на РЕД ОС 7.x"
    exit 1
fi

# Список доступных таблиц (вручную выделено из документа)
TABLES=(
    "1. Настройки доменной аутентификации"
    "2. Настройки аутентификации по ключу"
    "3. Настройки локальной аутентификации"
    "4. Отключение неиспользуемых сервисов"
    "5. Настройки регистрации событий (аудита)"
    "6. Настройка встроенных средств защиты информации"
)

echo "📋 Доступные категории настроек безопасности:"
for i in "${!TABLES[@]}"; do
    printf "%d) %s\n" "$((i+1))" "${TABLES[$i]}"
done

echo
read -p "Введите номер категории для анализа и проверки: " selection

if ! [[ "$selection" =~ ^[1-6]$ ]]; then
    echo "❌ Неверный выбор. Допустимы только значения 1-6."
    exit 1
fi

echo
echo "🔍 Выполняется проверка категории: ${TABLES[$((selection-1))]}"

# Здесь добавляется логика проверки по выбранной категории
case "$selection" in
    1)
        echo "➡ Проверка: Настройки доменной аутентификации"
        # Пример проверки:
        grep -q "cache_credentials = False" /etc/sssd/sssd.conf && echo "✅ cache_credentials отключен" || echo "⚠️ Необходимо отключить cache_credentials"
        grep -q "core_dumpable = False" /etc/sssd/sssd.conf && echo "✅ core_dumpable установлен" || echo "⚠️ Необходимо установить core_dumpable = False"
        grep -q "krb5_store_password_if_offline = False" /etc/sssd/sssd.conf && echo "✅ krb5_store_password_if_offline установлен" || echo "⚠️ Необходимо установить krb5_store_password_if_offline = False"
        ;;
    2)
        echo "➡ Проверка: Настройки аутентификации по ключу"
        grep -q "^PubkeyAuthentication yes" /etc/ssh/sshd_config && echo "✅ PubkeyAuthentication включен" || echo "⚠️ Необходимо включить PubkeyAuthentication"
        ;;
    3)
        echo "➡ Проверка: Настройки локальной аутентификации"
        grep -q "^PASS_MAX_DAYS[[:space:]]\+90" /etc/login.defs && echo "✅ PASS_MAX_DAYS = 90" || echo "⚠️ PASS_MAX_DAYS не установлен"
        ;;
    4)
        echo "➡ Проверка: Отключение cramfs, udf и других файловых систем"
        modprobe -n -v cramfs | grep -q 'install /bin/true' && echo "✅ cramfs отключен" || echo "⚠️ cramfs не отключен"
        ;;
    5)
        echo "➡ Проверка: Наличие и статус auditd"
        systemctl is-enabled auditd &>/dev/null && echo "✅ auditd включен" || echo "⚠️ auditd не включен"
        ;;
    6)
        echo "➡ Проверка: Защита ядра и системные параметры"
        grep -q "kernel.kptr_restrict = 2" /etc/sysctl.conf && echo "✅ kernel.kptr_restrict = 2 установлен" || echo "⚠️ kernel.kptr_restrict отсутствует"
        ;;
esac

echo
echo "🏁 Проверка завершена. Выполните соответствующие действия из колонки 'Детали конфигурации', если статус не ✅."
