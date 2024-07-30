##  Монтирование SMB 
```
sudo mount -t cifs  //{IP}/{DIR}/ /mnt/ -o username={name}
```
## Установка локально приложения 
```
sudo rpm -Uvh  *x86_64.rpm
```
## Установка плагина mapper  для  elasticsearch 
```
./elasticsearch-plugin install file:///mnt//mapper-size-7.17.18.zip
```

## Установка репозитория для SUSE и MOS OS 
```
zypper addrepo https://*repository/raw-repo-quantom-info/std-1/opensuse/15.4/x86_64 repo && zypper refresh 
```


