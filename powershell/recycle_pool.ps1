# Имя пула для перезапуска 
$AppPoolName = "NamePool"

# Путь к списку ВМ 
$MachinesFilePath = "C:\remotepc.txt"

# Прочитать из файла  remotepc.txt список ВМ 
$Machines = Get-Content -Path $MachinesFilePath

# Проход по каждому компьютеру и перезапустить пул приложений
foreach ($Machine in $Machines) {
    # Construct the remote PowerShell command
    $ScriptBlock = {
        param($AppPoolName)
        Import-Module WebAdministration
        #Start-Sleep -Seconds 10 # задержка 10 сек перед recycle 
        Restart-WebAppPool -Name $AppPoolName
    }
    
    # Выполнение команды на удаленной ВМ 
    Invoke-Command -ComputerName $Machine -ScriptBlock $ScriptBlock -ArgumentList $AppPoolName
}
