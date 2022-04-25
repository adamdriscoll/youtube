# [Advanced PowerShell - Runspaces](https://youtu.be/WvxUuru_vhk)

## List Runspaces

```powershell
Get-Runspace
```

## Create a runspace

```powershell
$Runspace = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateRunspace()
$Runspace.Open()
Get-Runspace 
$Runspace.Dispose()
```

### Execute Code in a Runspace

```powershell
$Runspace = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateRunspace()
$Runspace.Open()
$PowerShell = [PowerShell]::Create()
$PowerShell.Runspace = $Runspace 
$PowerShell.AddScript("Set-Variable -Name 'Test' -Value 123");
$PowerShell.Invoke()
$Test 
$PowerShell.Dispose()

$PowerShell = [PowerShell]::Create()
$PowerShell.Runspace = $Runspace 
$PowerShell.AddScript("Get-Variable -Name 'Test' -ValueOnly");
$PowerShell.Invoke()
```

### Execute Async

```powershell
$Runspace = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateRunspace()
$Runspace.Open()
$PowerShell = [PowerShell]::Create()
$PowerShell.Runspace = $Runspace 
$PowerShell.AddScript("1..10 | ForEach-Object { Start-Sleep 1 }; 'Hello, from another runspace!!' ");
$Result = $PowerShell.InvokeAsync() 
$Result.IsCompleted
$Result.Result
```

### Initialize a Runspace

```powershell
$init = [System.Management.Automation.Runspaces.InitialSessionState]::Create()
$init | Get-Member


$variable = [System.Management.Automation.Runspaces.SessionStateVariableEntry]::new("Test", 123, '')

$init.LanguageMode = 'FullLanguage'
$init.Variables.Add($variable)

$Runspace = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateRunspace($init)
$Runspace.Open()
$PowerShell = [PowerShell]::Create()
$PowerShell.Runspace = $Runspace 
$PowerShell.AddScript("`$Test");
$PowerShell.Invoke();
```

### Out of Process Runspaces

```powershell
$PID
$TypeTable = [System.Management.Automation.Runspaces.TypeTable]::LoadDefaultTypeFiles()
$Runspace = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateOutOfProcessRunspace($TypeTable)
$Runspace.Open()
$PowerShell = [PowerShell]::Create()
$PowerShell.Runspace = $Runspace 
$PowerShell.AddScript("`$PID");
$PowerShell.Invoke();
```

### Connection Info

```powershell
$CI = [System.Management.Automation.Runspaces.NamedPipeConnectionInfo]::new($ProcessId)
$Runspace = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateRunspace($CI)
$Runspace.Open()
$PowerShell = [PowerShell]::Create()
$PowerShell.Runspace = $Runspace 
$PowerShell.AddScript("`$PID");
$PowerShell.Invoke();

Get-Runspace
```

### Start-ThreadJob

```powershell
Start-ThreadJob { Start-Sleep 20 }
Get-Runspace
```