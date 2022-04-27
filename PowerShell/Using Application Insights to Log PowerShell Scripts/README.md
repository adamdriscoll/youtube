
# [Using Application Insights to Log PowerShell Scripts](https://youtu.be/asE5uCy8zYI)

```powershell
$client = [Microsoft.ApplicationInsights.TelemetryClient]::new()
$client.InstrumentationKey = '68ea4264-d61e-4cca-b048-90ca7aed435b'
$client.Context.User.Id = $Env:UserName
$Client.Context.Session.Id = $PID

# Trace
#[Microsoft.ApplicationInsights.DataContracts.SeverityLevel]
$client.TrackTrace("Hello, World!", "Error")
$Client.Flush()

# Metric
$client.TrackMetric("Metric", (Get-Random))
$Client.Flush()

# Metric with Properties
$dct = [System.Collections.Generic.Dictionary[string, string]]::new()
$dct.Add("LANG", $Env:LANG)
$Client.Flush()

$client.TrackMetric("Metric", (Get-Random), $dct)
$Client.Flush()

# PageView
$client.TrackPageView($MyInvocation.MyCommand.Name)
$Client.Flush()

# Exceptions
$client.TrackException([System.Exception]::new("Hello"))
$Client.Flush()

# Requests
function Measure-AICommand {

    param(
        $Name,
        $ScriptBlock
    )

    $sw = [System.Diagnostics.Stopwatch]::new()
    $sw.Start()

    $Status = "OK"
    try {
        & $ScriptBlock
    }
    catch {
        $status = $_.ToString();
    }

    $client.TrackRequest($name, (Get-Date), $sw.Elapsed, $status, $Status -eq "OK")
    $Client.Flush()

    $Sw.Stop()
}

Measure-AICommand -ScriptBlock {
    Start-Sleep (Get-Random -Min 1 -Max 5)
} -Name 'Sleeping'

# Dependency

function Test-Url {

    param(
        $Url
    )

    $sw = [System.Diagnostics.Stopwatch]::new()
    $sw.Start()

    $Status = $true
    try {
        Invoke-WebRequest -Uri $Url
    }
    catch {
        $Status = $false
    }

    $Client.TrackDependency("HTTP", $Url, "", (Get-Date), $sw.Elapsed, $status) 
    $Client.Flush() 

    $Sw.Stop()
}

Test-Url -Url 'https://www.ironmansoftware.com'



```