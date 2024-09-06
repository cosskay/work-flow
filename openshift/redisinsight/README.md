# RedisInsight on OpenShift

Этот репозиторий содержит конфигурационные файлы Kubernetes для развертывания RedisInsight в OpenShift. RedisInsight — это инструмент для управления и мониторинга Redis. Конфигурация включает Deployment и Service для RedisInsight.

``` bash 
oc create namespace redis
```
``` bash 
apply -f app.yaml
```

## Файлы

### `app.yaml`

Этот файл содержит манифесты Kubernetes для развертывания RedisInsight, включая конфигурации Deployment и Service.

### Конфигурация Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redisinsight
  namespace: redis
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redisinsight
  template:
    metadata:
      labels:
        app: redisinsight
    spec:
      containers:
        - name: redisinsight
          image: redislabs/redisinsight:1.14.0
          resources:
            requests:
              cpu: 200m
              memory: 500Mi
            limits:
              cpu: 200m
              memory: 500Mi
          ports:
            - containerPort: 8001
          env:
            - name: RIPROXYENABLE
              value: "true"
            - name: RITRUSTEDORIGINS
              value: "http://keydb-service.{$namespace}.svc.cluster.local"
            - name: NO_PROXY
              value: "localhost,127.0.0.1"
```
- name: redisinsight
- Namespace: redis
- replica: 1
- image: redislabs/redisinsight:1.14.0
- Port: Открывает порт контейнера 8001