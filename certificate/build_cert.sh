#!/bin/bash

set -e

CONFIG_FILE="config.cfg"

# Проверка существования конфигурационного файла
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "❌ Ошибка: файл конфигурации '$CONFIG_FILE' не найден."
    echo "Пожалуйста, создайте файл с необходимыми параметрами, например:"
    cat <<EOF
CN=example.com
O=Example Company
OU=IT Department
C=RU
ST=Moscow
L=Moscow
DAYS=365
EOF
    exit 1
fi

# Загрузка конфигурации
source "$CONFIG_FILE"

# Проверка обязательных параметров
missing=0
for var in CN O OU C ST L DAYS; do
    if [[ -z "${!var}" ]]; then
        echo "❌ Ошибка: переменная $var не задана в $CONFIG_FILE"
        missing=1
    fi
done

if [[ "$missing" -eq 1 ]]; then
    exit 1
fi

# Создание директории для сертификатов
CERT_DIR="certs"
mkdir -p "$CERT_DIR"

KEY_FILE="$CERT_DIR/${CN}.key"
CSR_FILE="$CERT_DIR/${CN}.csr"
CRT_FILE="$CERT_DIR/${CN}.crt"

echo "🔐 Генерация приватного ключа..."
openssl genrsa -out "$KEY_FILE" 2048 || {
    echo "❌ Ошибка при генерации ключа"
    exit 1
}

echo "📄 Генерация запроса на сертификат (CSR)..."
openssl req -new -key "$KEY_FILE" -out "$CSR_FILE" -subj "/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=$CN" || {
    echo "❌ Ошибка при генерации CSR"
    exit 1
}

echo "✅ Самоподписание сертификата на $DAYS дней..."
openssl x509 -req -days "$DAYS" -in "$CSR_FILE" -signkey "$KEY_FILE" -out "$CRT_FILE" || {
    echo "❌ Ошибка при самоподписании сертификата"
    exit 1
}

echo "✅ Сертификат успешно создан:"
echo "  🔑 Ключ:        $KEY_FILE"
echo "  📄 Запрос CSR:  $CSR_FILE"
echo "  📜 Сертификат:  $CRT_FILE"
