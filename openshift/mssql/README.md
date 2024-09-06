# MSSQL on OpenShift

Этот репозиторий содержит конфигурационные файлы Kubernetes для развертывания Microsoft SQL Server на OpenShift. Конфигурация включает использование Persistent Volume для хранения данных и LoadBalancer Service для внешнего доступа.

- **Убедитесь, что в вашем кластере OpenShift доступен класс хранилища (localstorage)**
- **Cilium используется для управления IP-адресами и сетевым трафиком через аннотацию io.cilium/lb-ipam-ips в Service.**

## Файлы

### `app.yaml`

Этот файл содержит файлы для развертывания MSSQL в Openshft, включая конфигурации Service, Deployment, PersistentVolumeClaim и Secret.

### Конфигурация Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mssql-service
  annotations:
    io.cilium/lb-ipam-ips: 10.42.15.86
spec:
  externalTrafficPolicy: Cluster
  ports:
    - name: port
      port: 1433
      protocol: TCP
      targetPort: 1433
  selector:
    app: mssql
  type: LoadBalancer
```
- Имя: mssql-service
- Тип: LoadBalancer
- Порт: 1433
- Селектор: Соответствует метке app: mssql на развертывании.
Аннотация Cilium: Используется аннотация io.cilium/lb-ipam-ips для управления IP-адресами при помощи Cilium. Эта аннотация указывает, что для данного LoadBalancer должен быть использован конкретный IP-адрес.

### Конфигурация Deployment

- Имя: mssql-deployment
- Реплика: 1
- Образ: mssql/rhel/server:2019-CU20-rhel-8.7
- Порт: Открывает порт контейнера 1433
- Переменные окружения: Настроены для MSSQL экземпляра с паролем SA, получаемым из Kubernetes Secret
- Монтирование томов: Использует Persistent Volume Claim с именем mssql-pvc для хранения данных


### Конфигурация PersistentVolumeClaim

- Имя: mssql-pvc
- Режим доступа: ReadWriteOnce
- Запрашиваемое хранилище: 250Gi
- Класс хранилища: localstorage

### Конфигурация Secret
- Имя: mssql
- Тип: Opaque
- Passwd: Пароль SA для SQL Server в закодированном формате Base64.
