# [Find Open Files in PowerShell](https://youtu.be/rPQTKQBTFLo)

Published: 4/22/2022

## Install Module

```powershell
Install-Module FindOpenFile
```

## Find a Locked File

```powershell
Find-OpenFile -FilePath .\mylockedFile.txt
```

## File Files used by a Process

```powershell
Find-OpenFile -Process (Get-Proces -Id $PID)
```