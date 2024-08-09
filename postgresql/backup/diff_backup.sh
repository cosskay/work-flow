#!/bin/bash
# Скрипт для дифференциального резервного копирования

TIMESTAMP=$(date +"%Y%m%d")
BACKUP_DIR="/path/to/backup/diff/${TIMESTAMP}"

mkdir -p ${BACKUP_DIR}

pg_basebackup -D ${BACKUP_DIR} -Ft -z -P -X fetch -l "daily_backup_${TIMESTAMP}" -U backup_user

# Удалите старые резервные копии, если это необходимо
find /mnt/backup/diff -type d -mtime +30 -exec rm -rf {} \;

