## Увеличение диска LVM 
``` sh 
parted /dev/sda
(parted) resizepart 2 100%
(parted) quit

pvresize /dev/sda2

lvextend -l +100%FREE /dev/centos_7/root

xfs_growfs /

resize2fs /dev/centos_otrs_7/root
```
