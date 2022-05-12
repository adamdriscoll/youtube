param($File)

$Json = Get-Content $File | ConvertFrom-Json 
Write-Host $Json.Say