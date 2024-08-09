#!/bin/bash
# Скрипт для резервного копирования WAL

TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_DIR="/path/to/backup/wal/${TIMESTAMP}"

mkdir -p ${BACKUP_DIR}
cp /data/pg_wal_archive/* ${BACKUP_DIR}

# Удалите старые архивные файлы, если это необходимо
find /path/to/backup/wal -type d -mtime +7 -exec rm -rf {} \;

