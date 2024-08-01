# Iptable

## Для перенаправления входящего трафика на другие IP-адреса и порты используем правила в таблице nat:

## Перенаправление FTP трафика на внутренний сервер
```
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 21 -j DNAT --to-destination 10.0.4.1
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 20 -j DNAT --to-destination 10.0.4.1

 Перенаправление FTP трафика на внутренний сервер
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 21 -j DNAT --to-destination 10.0.4.1
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 20 -j DNAT --to-destination 10.0.4.1

 Перенаправление диапазона портов FTP на внутренний сервер
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 50000:51000 -j DNAT --to-destination 10.0.4.1:50000-51000

```
## Настроим правила для изменения исходящего IP-адреса при отправке пакетов на целевой сервер:
```
iptables -t nat -A POSTROUTING -d 10.207.4.10 -p tcp -m tcp --dport 21 -j SNAT --to-source 10.0.4.2
iptables -t nat -A POSTROUTING -d 10.207.4.10 -p tcp -m tcp --dport 20 -j SNAT --to-source 10.0.4.2
iptables -t nat -A POSTROUTING -d 10.207.4.10 -p tcp -m tcp --dport 50000:51000 -j SNAT --to-source 10.0.4.2
```

## проверить связь ftp :
```
curl -P - --insecure "ftp://10.0.4.2" --user "USER:PASSWD" 
```

