# [PowerShell Command Line Debugging](https://youtu.be/TCs8KmyZCgs)

Debugging Commands

```powershell
Wait-Debugger

Set-PSBreakpoint -Script debugging.ps1 -Line 4 
Set-PSBreakpoint -Script debugging.ps1 -Line 1,2,3,4 

Set-PSBreakpoint -Variable 'Line' -Mode ReadWrite
Set-PSBreakpoint -Variable 'Line' -Mode Read 
Set-PSBreakpoint -Variable 'Line' -Mode Write  

Set-PSBreakpoint -Command Write-Line

Set-PSBreakpoint -Variable 'Line' -Mode Write -Action {
    Write-Host $Line
}

Set-PSBreakpoint -Variable 'Line' -Mode Write -Action {
	if ($Line -eq 5)
      {
		break
      }
}

$ErrorActionPreference = 'break'

Enter-PSHostProcess
Get-Runspace
Debug-Runspace 

```

Runspace Script 

```powershell

function Write-Line {
    $Line = $args[0]
    [Console]::WriteLine($Line)
}

for ($i = 0; $i -lt 10; $i++) {
    Write-Line $i
}

function global:Start-Runspace {
    $RS = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateRunspace()
    $RS.Open()
    $PS = [System.Management.Automation.PowerShell]::Create()
    $PS.Runspace = $RS 
    $PS.AddScript("Wait-Debugger").InvokeAsync() | Out-Null
}
```