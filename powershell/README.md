##  Проверить время ответа REST запроса с каждой ноды в кластере 
```
# список днс имени в файле записаный на каждой строке
$hostnames = Get-Content "C:\remotepc.txt"
foreach ($hostname in $hostnames) {
    $uri = "http://$($hostname):PORT/path/"
    
    try {
        # Start the timer
        $startTime = Get-Date
        
        # Send the request and get the response objectr
        $response = Invoke-WebRequest -Uri $uri
        $statusCode = $response.StatusCode
        
        # Calculate the response time
        $responseTime = (Get-Date) - $startTime
        
        Write-Output "Computer Name: $hostname, StatusCode: $statusCode, Response Time: $($responseTime.TotalMilliseconds) ms"
    } catch {
        Write-Output "Failed to connect to $hostname"
    }
}

# Вывод будет имя ПК , ответ сервера ,  Время ответа от сервера
```

##  Проверка  работы  IIS сайтов  на удаленных серверах 
```

# Путь к файлу со списком удаленных компьютеров
$computerListFile = "C:\remotepc.txt"

# Проверка состояния службы IIS
$serviceName = "W3SVC"  # Имя службы IIS

# Получение списка компьютеров из файла
$computers = Get-Content -Path $computerListFile

# Проверка наличия файла
if (-not (Test-Path $computerListFile)) {
    Write-Host "Файл $computerListFile не найден."
    exit
}

# Проверка состояния службы и сайтов на каждом компьютере
foreach ($computer in $computers) {
    Write-Host "Проверка на компьютере: $computer"
    
    # Подключение к удаленному компьютеру
    try {
        $service = Get-Service -Name $serviceName -ComputerName $computer -ErrorAction Stop

        # Проверка состояния службы
        if ($service.Status -eq "Running") {
            Write-Host "Служба IIS работает на $computer."
        } else {
            Write-Host "Служба IIS остановлена на $computer."
        }

        # Получение информации о сайтах на удаленном компьютере
        $sites = Invoke-Command -ComputerName $computer -ScriptBlock { Get-Website } -ErrorAction Stop

        # Проверка состояния каждого сайта
        foreach ($site in $sites) {
            if ($site.State -eq "Started") {
                Write-Host "Сайт $($site.Name) запущен на $computer."
            } else {
                Write-Host "Сайт $($site.Name) остановлен на $computer." -ForegroundColor Green
            }
        }
    } catch {
        Write-Host "Ошибка при подключении к {$computer}: $_" -ForegroundColor Green
    }

    Write-Host ""
}

```
