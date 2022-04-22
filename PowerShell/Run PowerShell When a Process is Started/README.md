# [Run PowerShell When a Process is Started](https://youtu.be/rPQTKQBTFLo)

Published: 4/23/2022

## Register Event

```powershell
$query = 'Select * From __InstanceCreationEvent Within 2 Where TargetInstance Isa "Win32_Process" And TargetInstance.Name = "notepad.exe"'

Register-CimIndicationEvent -SourceIdentifier 'NewProcess' -Query $query -Action {
}
```

## Unregister Event

```powershell
Unregister-Event -SourceIdentifier 'NewProcess'
```

## Print Process Information

```powershell
$query = 'Select * From __InstanceCreationEvent Within 2 Where TargetInstance Isa "Win32_Process" And TargetInstance.Name = "notepad.exe"'

Register-CimIndicationEvent -SourceIdentifier 'NewProcess' -Query $query -Action {
    Write-Host ($EventArgs.NewEvent.TargetInstance | Out-String)
}
```

## Stop a Process After It Has Started

```powershell
$query = 'Select * From __InstanceCreationEvent Within 2 Where TargetInstance Isa "Win32_Process" And TargetInstance.Name = "notepad.exe"'

Register-CimIndicationEvent -SourceIdentifier 'NewProcess' -Query $query -Action {
    Get-Process -Id $EventArgs.NewEvent.TargetInstance.ProcessId | Stop-Process
}
```