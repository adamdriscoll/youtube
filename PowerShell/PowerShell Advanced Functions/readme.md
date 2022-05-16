# [PowerShell Advanced Functions](https://youtu.be/pHkAP78KDJk)

```powershell
$ScryfallApi = "https://api.scryfall.com"

function Get-MTGCard {
    [CmdletBinding(DefaultParameterSetName = "Random")]
    [OutputType([MtgCard])]
    param(
        [Parameter(ParameterSetName = 'Named', Mandatory)]
        [string]$Name,
        [Parameter(ParameterSetName = 'Id', Mandatory)]
        [Guid]$Id
    )

    if ($PSCmdlet.ParameterSetName -eq 'Random') {
        Invoke-RestMethod "$ScryfallApi/cards/random" 
    }
    elseif ($PSCmdlet.ParameterSetName -eq 'Named') {
        Invoke-RestMethod "$ScryfallApi/cards/named?fuzzy=$Name"
    }    
    elseif ($PSCmdlet.ParameterSetName -eq 'Id') {
        Invoke-RestMethod "$ScryfallApi/cards/$Id"
    }    
}

function Find-MTGCard {
    [CmdletBinding(SupportsPaging = $true, SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        $Query
    )

    if (-not $PSCmdlet.ShouldContinue(($Query, "Are you sure you want to search Scryfall?"))) {
        return
    }

    $Page = $PSCmdlet.PagingParameters.Skip + 1

    Invoke-RestMethod "$ScryfallApi/cards/search?q=$Query&page=$Page"
}

function Show-MTGCard {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(ValueFromPipeline = $true)]$Card
    )

    Begin {
        $Cards = @()
    }

    Process {
        $Cards += $Card
    }

    End {
        $Cards | ForEach-Object {
            Start-Process $Card.image_uris.large
        }
    }
}

Register-ArgumentCompleter -CommandName 'Get-MTGCard' -ParameterName 'Name' -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    (Invoke-RestMethod "$ScryfallApi/cards/autocomplete?q=$wordToComplete").Data | ForEach-Object { "'$_'" }
}

class MtgCard {
    [guid]$id 
    [string]$name 
    [PSCustomObject]$image_uris
}
```