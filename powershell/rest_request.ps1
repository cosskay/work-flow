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
