# [Creating Resilient PowerShell scripts with PSPolly](https://youtu.be/dEs3BUc2R7w)

```powershell
$Policy = New-PollyPolicy -Retry -RetryCount 10
Invoke-PollyCommand -Policy $Policy -ScriptBlock {
    Write-Host "Trying.."
    throw "Failed"
}



$Policy = New-PollyPolicy -Retry -RetryCount 3 -RetryWait @(
    New-TimeSpan -Seconds 1
    New-TimeSpan -Seconds 3
    New-TimeSpan -Seconds 5
)
Invoke-PollyCommand -Policy $Policy -ScriptBlock {
    Write-Host "Trying.."
    throw "Failed"
}


$Policy = New-PollyPolicy -RetryForever -SleepDuration {
    $Random = Get-Random -Min 1 -Max 10
    Write-Host "Sleeping for $Random seconds"
    New-TimeSpan -Seconds $Random
}
Invoke-PollyCommand -Policy $Policy -ScriptBlock {
    Write-Host "Trying.."
    throw "Failed"
}


$Policy = New-PollyPolicy -CircuitBreaker -ExceptionsAllowedBeforeBreaking 3 -DurationOfBreak (New-TimeSpan -Seconds 5)
1..10 | ForEach-Object {
    try 
    {
        Invoke-PollyCommand -Policy $Policy -ScriptBlock {
            Write-Host "Trying.."
            throw "Failed"
        }
    }
    catch 
    {
        $_
    }
}


$Policy = New-PollyPolicy -AbsoluteExpiration (Get-Date).AddHours(1)
Invoke-PollyCommand -Policy $Policy -ScriptBlock {
    Get-Process; Start-Sleep 5
} -OperationKey 'Absolute'



$CircuitBreaker = New-PollyPolicy -CircuitBreaker -ExceptionsAllowedBeforeBreaking 3 -DurationOfBreak (New-TimeSpan -Seconds 5)
$Retry = New-PollyPolicy -Retry -RetryCount 10
$Policy = Join-PollyPolicy -Policy @($CircuitBreaker, $Retry)
1..10 | ForEach-Object {
    Invoke-PollyCommand -Policy $Policy -ScriptBlock {
        Write-Host "Trying.."
        throw "Failed"
    }
}
```