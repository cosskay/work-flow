#!/bin/bash

# Параметры базы данных
DB_USER="{USER}"
DB_PASSWORD="{PASSWORD}"
DB_NAME="{DB-NAME}"

# Путь для хранения резервных копий
BACKUP_PATH="{PATH}"

# Текущая дата и время
DATE=$(date +%Y%m%d_%H%M%S)

# Имя файла резервной копии
BACKUP_FILE="${BACKUP_PATH}/${DB_NAME}_${DATE}.sql"
BACKUP_ARCHIVE="${BACKUP_FILE}.gz"

# Выполнение резервного копирования
mysqldump -u "${DB_USER}" -p"${DB_PASSWORD}" "${DB_NAME}" > "${BACKUP_FILE}"

# Проверка успешности выполнения резервного копирования
if [ $? -eq 0 ]; then
  # Архивация резервной копии
  gzip "${BACKUP_FILE}"

  # Проверка успешности архивации
  if [ $? -eq 0 ]; then
    echo "Резервное копирование и архивация выполнены успешно: ${BACKUP_ARCHIVE}"
  else
    echo "Ошибка архивации резервной копии!" >&2
  fi
else
  echo "Ошибка резервного копирования базы данных!" >&2
fi

