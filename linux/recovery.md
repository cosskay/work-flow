## Восстановление  виртуальной машины VMware c TrueNas на борту

Проблема :  вирутальная машина не стартовала после физического сбоя HDD , снапшот тоже запускался.  Необходимо получить данные с вирутальной машины и перенести на другой сервер. 
Рабочая ВМ с ubuntu + файловое хранилище для работы с дисками . 

Переношу ВМ на файловое хранилище , для этого надо включить ssh  доступ на ESXI , далее через  scp или winspc переносим данные ВМ . 

Утилиты для работы с диском 
``` bash 
apt install qemu-utils
apt install smbclient
apt install zfsutils-linux
apt install testdisk
```

Монтируем хранилище  : 
``` bash 
sudo mount -t cifs -o username=USERNAME ,password=PASSWD,vers=1.0 //192.168.0.250/Distributives /mnt/distibutives 
```
Даем права на файлы 
``` bash 
chmod 774 /mnt/distibutives/disk/*
```

Подключаем модуль ядра 
``` bash 
sudo modprobe nbd
```

Подключаем проблемный диск VMware
``` bash 
sudo qemu-nbd --connect=/dev/nbd0 filename.vmdk
```
Находим разделы 
``` bash 
fdisk -l /dev/nbd0
lsblk /dev/nbd0
```
ZFS работает с пулами данных. Чтобы получить доступ к данным, нужно импортировать пул
``` bash 
zpool import 

Пример вывода:
  pool: file-share
  id: 254789456211

```
Импорт пула  в режиме  только чтение , так как на запись монтирование  будет с ошибкой 

``` bash 
 sudo zpool import -f -o readonly=on file-share
 ```

После импорта пула точка монтирования будет в корень 
``` bash 

ll / 
```
Файлы готовы для переноса  копируем содержимое 
``` bash 
cp -r /file-share /mnt/share
```

Столкнулся с проблемой  word exel файлы не открывались , решение было поставить LibreOffice  которая открыла файлы без проблем . 
