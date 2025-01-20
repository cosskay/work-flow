$excelFilePath = "C:\admin\in_document.xlsx"

# Создаем объект Excel
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false  

# Открываем файл Excel
$workbook = $excel.Workbooks.Open($excelFilePath)

# Получаем первый лист
$sheet = $workbook.Sheets.Item(1)

$rowCount = $sheet.UsedRange.Rows.Count

# Цикл по строкам
for ($i = 2; $i -le $rowCount; $i++) {
    # Получаем значения из колонок A (Name) и B, C, D, E (Path)
    $name = $sheet.Cells.Item($i, 1).Value2
    $path = "$($sheet.Cells.Item($i, 2).Value2),$($sheet.Cells.Item($i, 3).Value2),$($sheet.Cells.Item($i, 4).Value2),$($sheet.Cells.Item($i, 5).Value2)"

    # Проверяем, существует ли уже OU
    $ouExists = Get-ADOrganizationalUnit -Filter {Name -eq $name -and DistinguishedName -like "*$path*"} -ErrorAction SilentlyContinue

    if ($ouExists) {
        Write-Host "Подразделение '$name' уже существует. Пропускаем создание."
    } else {
        # Формируем команду для создания подразделения
        $command = "New-ADOrganizationalUnit -Name `"$name`" -Path `"$path`""

        Write-Host "Выполняем команду: $command"

        Invoke-Expression $command
    }
}

# Закрываем Excel
$workbook.Close($false)
$excel.Quit()

# Освобождаем ресурсы
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($workbook) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($sheet) | Out-Null