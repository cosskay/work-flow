#!/bin/bash
# Скрипт для полного резервного копирования

TIMESTAMP=$(date +"%Y%m%d")
BACKUP_DIR="/path/to/backup/full/${TIMESTAMP}"

mkdir -p ${BACKUP_DIR}

pg_basebackup -D ${BACKUP_DIR} -Ft -z -P -X fetch -l "full_backup_${TIMESTAMP}" -U backup_user

# Удалите старые резервные копии, если это необходимо
find /mnt/backup/full -type d -mtime +60 -exec rm -rf {} \;

