# [PowerShell Advanced Functions](https://youtu.be/pHkAP78KDJk)

```powershell
$ScryfallApi = "https://api.scryfall.com"

function Get-MTGCard {
    [CmdletBinding(DefaultParameterSetName = "Random")]
    [OutputType([MtgCard])]
    param(
        [Parameter(ParameterSetName = 'Named', Mandatory)]
        [string[]]$Name,
        [Parameter(ParameterSetName = 'Id', Mandatory)]
        [Guid[]]$Id
    )
    
    $restMethodParams = @{
        Uri = "$ScryfallApi/cards/random"
    }

    if ($PSCmdlet.ParameterSetName.Contains('Random')) {
        Invoke-RestMethod @restMethodParams
    }
    else {
        foreach ($card in $PSBoundParameters[$PSBoundParameters.Keys]) {
            if ($PSBoundParameters.ContainsKey('Name')) {
                $restMethodParams.Uri = "$ScryfallApi/cards/named?fuzzy=$card"
            }
            elseif ($PSBoundParameters.ContainsKey('Id')) {
                $restMethodParams.Uri = "$ScryfallApi/cards/$card"
            }
            Invoke-RestMethod @restMethodParams
        }
    }
    
}

function Find-MTGCard {
    [CmdletBinding(SupportsPaging, SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        $Query
    )

    if ($PSCmdlet.ShouldProcess("$Query", "Find")) {
        $Page = $PSCmdlet.PagingParameters.Skip + 1
        Invoke-RestMethod "$ScryfallApi/cards/search?q=$Query&page=$Page"
    }
}

function Show-MTGCard {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(ValueFromPipeline)]
        $Card
    )

    Begin {
       
    }

    Process {
        foreach ($Item in $Card) {
            if ($PSCmdlet.ShouldProcess("$($Item.image_uris.large)", "Opening")) {
                Start-Process -FilePath $Item.image_uris.large
            }
        }
    }
    End {

    }
}

Register-ArgumentCompleter -CommandName 'Get-MTGCard' -ParameterName 'Name' -ScriptBlock {
    param(
        $commandName, 
        $parameterName, 
        $wordToComplete, 
        $commandAst,
        $fakeBoundParameters
    )
    (Invoke-RestMethod "$ScryfallApi/cards/autocomplete?q=$wordToComplete").Data | ForEach-Object { "'$PSItem'" }
}

class MtgCard {
    [guid]$id 
    [string]$name 
    [PSCustomObject]$image_uris
}
```
