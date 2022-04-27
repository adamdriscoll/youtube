# [Create PowerShell Cmdlets for Command Line Tools with Crescendo ](https://youtu.be/c9m7ZdSwgkQ)

## Logon Sessions 

```powershell
$NewConfiguration = @{
    '$schema' = 'https://aka.ms/PowerShell/Crescendo/Schemas/2021-11'
    Commands  = @()
}
$parameters = @{
    Verb         = 'Get'
    Noun         = 'Logonsession'
    OriginalName = ".\logonsessions.exe"
}
$NewConfiguration.Commands += New-CrescendoCommand @parameters
$NewConfiguration | ConvertTo-Json -Depth 3 | Out-File .\logonsessions.json
```

## PsExec 

```powershell
$NewConfiguration = @{
    '$schema' = 'https://aka.ms/PowerShell/Crescendo/Schemas/2021-11'
    Commands  = @()
}
$parameters = @{
    Verb         = 'Start'
    Noun         = 'PsExec'
    OriginalName = ".\psexec.exe"
}
$NewConfiguration.Commands += New-CrescendoCommand @parameters
$NewConfiguration | ConvertTo-Json -Depth 3 | Out-File .\psexec.json
```

## Generate 

```powershell
Export-CrescendoModule -ConfigurationFile psexec.json -ModuleName psexec.psm1 -Force
Export-CrescendoModule -ConfigurationFile logonsessions.json -ModuleName logonsessions.psm1 -Force
```

## LogonSessions.json

```json
{
  "$schema": "https://aka.ms/PowerShell/Crescendo/Schemas/2021-11",
  "Commands": [
    {
      "Verb": "Get",
      "Noun": "Logonsession",
      "OriginalName": ".\\logonsessions.exe",
      "OriginalCommandElements": [
        "-accepteula",
        "-nobanner",
        "-c"
      ],
      "Platform": [
        "Windows"
      ],
      "Elevation": null,
      "Aliases": null,
      "DefaultParameterSetName": null,
      "SupportsShouldProcess": false,
      "ConfirmImpact": null,
      "SupportsTransactions": false,
      "NoInvocation": false,
      "Description": null,
      "Usage": null,
      "Parameters": [],
      "Examples": [],
      "OriginalText": null,
      "HelpLinks": null,
      "OutputHandlers": [
        {
          "Handler": "$args[0] | ConvertFrom-CSV",
          "HandlerType": "Inline",
          "ParameterSetName": "Default",
          "StreamOutput": false
        }
      ]
    }
  ]
}
```

## PsExec.json

```json
{
  "$schema": "https://aka.ms/PowerShell/Crescendo/Schemas/2021-11",
  "Commands": [
    {
      "Verb": "Start",
      "Noun": "PsExec",
      "OriginalName": ".\\psexec.exe",
      "OriginalCommandElements": [
        "-accepteula",
        "-nobanner'
      ],
      "Platform": [
        "Windows"
      ],
      "Elevation": null,
      "Aliases": null,
      "DefaultParameterSetName": null,
      "SupportsShouldProcess": false,
      "ConfirmImpact": null,
      "SupportsTransactions": false,
      "NoInvocation": false,
      "Description": null,
      "Usage": null,
      "Parameters": [
        {
          "ParameterType": "String",
          "OriginalPosition": 0,
          "Name": "ComputerName"
        },
        {
          "ParameterType": "String",
          "OriginalPosition": 1,
          "Mandatory": true,
          "Name": "Command"
        },
        {
          "ParameterType": "String",
          "OriginalPosition": 2,
          "Name": "Arguments"
        },
        {
          "ParameterType": "switch",
          "OriginalName": "-s",
          "Name": "System"
        }
      ],
      "Examples": [],
      "OriginalText": null,
      "HelpLinks": null,
      "OutputHandlers": null
    }
  ]
}
```