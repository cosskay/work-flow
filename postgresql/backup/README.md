## Настройка postgresql для бэкапа 
```
wal_level = replica
archive_mode = on
archive_command = 'cp %p /data/pg_wal_archive/%f'
archive_timeout = 60s
```
sudo systemctl restart postgresql


```
chmod +x wal_backup.sh
crontab -e
0 * * * * /srv/wal_backup.sh
```

```
chmod +x diff_backup.sh
crontab -e
0 2 * * * /srv/diff_backup.sh
```

```
chmod +x full_backup.sh
crontab -e
0 2 * * * /srv/full_backup.sh
```
## Отправка сообщения в телеграм
```
send_telegram.sh
```
