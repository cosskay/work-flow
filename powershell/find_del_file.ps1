$folderPath = "E:\Share\Storage"
$dateFrom = Get-Date "2021-01-01"
$dateTo = Get-Date "2021-12-31"

Get-ChildItem -Path $folderPath -File -Recurse | Where-Object { $_.CreationTime -ge $dateFrom -and $_.CreationTime -le $dateTo } | Remove-Item -Force
