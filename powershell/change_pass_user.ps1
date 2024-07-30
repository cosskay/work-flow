# Пароль пользователя 'USER'
$passwd = "Yzw%YYv*47E&6k"

# Чтение списка компьютеров из файла
$computers = Get-Content "C:\remotepc.txt"
foreach ($computer in $computers) {
    try {
        $user = [ADSI]("WinNT://$computer/USER,user")
        $user.SetPassword($passwd)
        $user.SetInfo()
        Write-Host "Пароль для пользователя 'USER' на компьютере $computer успешно изменен." -ForegroundColor Green
    } catch {
        Write-Host "Не удалось изменить пароль для пользователя 'USER' на компьютере {$computer}: $_" -ForegroundColor Red
    }
}

