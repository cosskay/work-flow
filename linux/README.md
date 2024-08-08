##  Монтирование SMB 
```
sudo mount -t cifs  //{IP}/{DIR}/ /mnt/ -o username={name}
```
## Установка локально приложения 
```
sudo rpm -Uvh  *x86_64.rpm
```

## Установка репозитория для SUSE и MOS OS 
```
zypper addrepo https://*repository/raw-repo-quantom-info/std-1/opensuse/15.4/x86_64 repo && zypper refresh 
```

## Увеличение lvm тома 
### информация о диске
```
lsblk
fdisk -l
sda                             8:0    0   55G  0 disk
├─sda1                          8:1    0    1G  0 part /boot
└─sda2                          8:2    0   39G  0 part
  ├─centos_7--hp2020-root 253:0    0   37G  0 lvm  /
  └─centos_7--hp2020-swap 253:1    0    2G  0 lvm  [SWAP]
```
## Изменения настроек 
```
parted /dev/sda
(parted) resizepart 2 100%
(parted) quit

pvresize /dev/sda2

lvextend -l +100%FREE /dev/centos_otrs7-hp2020/root

xfs_growfs /

resize2fs /dev/centos_otrs7-hp2020/root
```
