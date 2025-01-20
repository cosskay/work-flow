# Укажите путь к LDF-файлу
$ldfFilePath = "C:\Users\admin\decoded___file.ldf"  
$outputCsvPath = "C:\Users\admin\decoded___file.csv"  

$ldfContent = Get-Content -Path $ldfFilePath -Raw

$records = $ldfContent -split "(?ms)^dn: "

$groupMemberData = @()


foreach ($record in $records) {
   
    if ($record -match "(?ms)^cn=.*?objectClass: group") {
       
        if ($record -match "^(cn=.*?),") {
            $groupDN = $matches[1]
        } else {
            continue
        }

        $members = @()
        foreach ($line in $record -split "`n") {
            if ($line -match "^member: (.+?),") {
                $members += $matches[1]
            }
        }

        foreach ($memberDN in $members) {
            $groupMemberData += [PSCustomObject]@{
                GroupDN = $groupDN
                UserDN  = $memberDN
            }
        }
    }
}

if ($groupMemberData.Count -eq 0) {
    Write-Host "Не найдено пользователей с группами в файле $ldfFilePath"
    exit
}

$groupMemberData | Export-Csv -Path $outputCsvPath -NoTypeInformation -Encoding UTF8

Write-Host "Данные успешно сохранены в файл $outputCsvPath"
