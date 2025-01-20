# Путь к файлу с данными
$ldifFile = "C:\admin\decoded_file.ldf"
$outputCsvFile = "C:\admin\decoded_file.csv" 

# Чтение данных из файла
$lines = Get-Content $ldifFile -Encoding UTF8 

# Массив для хранения подразделений
$organizationalUnits = @()

# HashSet для уникальности (на основе FullDN)
$uniqueFullDNs = @{}

# Обработка каждой строки
foreach ($line in $lines) {
   
    if ($line.StartsWith("dn:")) {
       
        $dn = $line.Substring(3).Trim()
        if ($uniqueFullDNs.Contains($dn)) {
            continue
        }

        $uniqueFullDNs[$dn] = $true

        $dnParts = $dn.Split(",") 

        # Получаем название OU (после "ou=")
        $ouName = $dnParts[0].Split("=")[1].Trim()

        # Получаем родительский путь (оставшиеся части DN)
        $parentOU = ($dnParts[1..($dnParts.Length - 1)] -join ",").Trim()

        # Добавляем в список
        $organizationalUnits += [PSCustomObject]@{
            OUName = $ouName
            ParentOU = $parentOU
            FullDN = $dn
        }
    }
}

# Заголовки CSV
$headers = "OUName,ParentOU,FullDN"

# Сохранение в UTF-8 
$stream = [System.IO.StreamWriter]::new($outputCsvFile, $false, [System.Text.Encoding]::UTF8)
$stream.WriteLine($headers)

# Добавляем данные
foreach ($ou in $organizationalUnits) {
    $line = "$($ou.OUName),$($ou.ParentOU),$($ou.FullDN)"
    $stream.WriteLine($line)
}

$stream.Close()

Write-Host "Данные сохранены в UTF-8 в файл: $outputCsvFile без дублей"