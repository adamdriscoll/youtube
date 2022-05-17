# [Calling REST APIs with Invoke-RestMethod in PowerShell](https://youtu.be/wpquzkKGxVM)

## Invoke-RestMethod Examples

```powershell
Invoke-RestMethod http://localhost:5000/methods -Method GET

Invoke-RestMethod http://localhost:5000/statusCode/401 -Method GET

Invoke-RestMethod http://localhost:5000/api/v1/user

Invoke-RestMethod http://localhost:5000/api/v1/user -Method POST -Body @{
    UserName = "Adam" 
}

Invoke-RestMethod http://localhost:5000/api/v1/user/1

Invoke-RestMethod 'http://localhost:5000/json' -Method POST -Body (@{
    Message = 'Welcome to the rodeo!'
} | ConvertTo-Json) -ContentType 'application/json'

Invoke-RestMethod 'http://localhost:5000/form' -Method POST -Body @{
    FirstName = "Adam"
    LastName = "Driscoll"
}

invoke-restmethod http://localhost:5000/file -InFile .\Select-Node.md -Method Post  -OutFile .\OneDrive\Desktop\file.zip

Invoke-RestMethod http://localhost:5000/headers -Headers @{
    MySuperCoolHeader = "My Super Cool Value"
}

Invoke-RestMethod http://localhost:5000/headers -ContentType "text/plain"
Invoke-RestMethod http://localhost:5000/headers -UserAgent "Red Star Linux"

Invoke-RestMethod "http://localhost:5000/querystring?query=ThisIsAQuery"
Invoke-RestMethod "http://localhost:5000/querystring?query=This Is A Query"
Invoke-RestMethod "http://localhost:5000/querystring?query=ThisIsAQuery&Page=2"

Invoke-RestMethod http://localhost:5000/cookie -SessionVariable MySession
$MySession
$MySession.Cookies.GetAllCookies()
Invoke-RestMethod http://localhost:5000/cookie -WebSession $MySession

$AppToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiYWRtaW4iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9oYXNoIjoiYjNjMjE2OTktOWYxYi00NmQ5LWIyZTUtZjI0MDM4NWM1ZWJkIiwic3ViIjoiUG93ZXJTaGVsbFVuaXZlcnNhbCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkFkbWluaXN0cmF0b3IiLCJuYmYiOjE2NTI4MjAyNzcsImV4cCI6MjExMDc0Mzg0MCwiaXNzIjoiSXJvbm1hblNvZnR3YXJlIiwiYXVkIjoiUG93ZXJTaGVsbFVuaXZlcnNhbCJ9.O40EsVLIAd6dfmVxYaygbUA4X2e8waTkDErkNie6IQg"
Invoke-Restmethod http://localhost:5000/secret -Headers @{
    Authorization = "Bearer $AppToken"
}
Invoke-Restmethod http://localhost:5000/secret -UseDefaultCredentials -AllowUnencryptedAuthentication
Invoke-RestMethod http://localhost:5000/random -MaximumRetryCount 10 -RetryIntervalSec 1 -Verbose

Invoke-RestMethod http://localhost:5000/redirect -MaximumRedirection 0
Invoke-RestMethod http://localhost:5000/timeout -TimeoutSec 3
```

## PowerShell Universal Configuration

```powershell
New-PSUEndpoint -Url "/methods" -Method @('GET', 'POST', 'PUT', 'DELETE', 'OPTIONS') -Endpoint {
$Method
} 
New-PSUEndpoint -Url "/statusCode/:number" -Method @('GET') -Endpoint {
param($number)

    New-PSUApiResponse -StatusCode $number
} 
New-PSUEndpoint -Url "/api/v1/user" -Method @('GET') -Endpoint {
$Cache:User
} 
New-PSUEndpoint -Url "/api/v1/user" -Method @('POST') -Endpoint {
param($UserName)

    if (-not $Cache:User)
    {
        $Cache:User = [System.Collections.ArrayList]::new()
    }

    $Cache:User.Add(@{
        UserName = $UserName
        Id = $Cache:User.Count + 1
    }) | Out-Null
} 
New-PSUEndpoint -Url "/api/v1/user/:id" -Method @('GET') -Endpoint {
param($Id)

    $Cache:User.where({$_.Id -eq $Id})
} 
New-PSUEndpoint -Url "/json" -Method @('POST') -Endpoint {
Write-Host ($Headers["Content-Type"])
Write-Host ($Body)

    $Object = $Body | ConvertFrom-Json
    "You said '$($Object.Message)'"
} 
New-PSUEndpoint -Url "/form" -Method @('POST') -Endpoint {
param($FirstName, $LastName)

    Write-Host ($Headers["Content-Type"])
    Write-Host $body 
    
    "Hello, $FirstName $LastName!"
} 
New-PSUEndpoint -Url "/file" -Method @('POST') -Endpoint {
ipmo "C:\program files\powershell\7\Modules\Microsoft.PowerShell.Archive\Microsoft.PowerShell.Archive.psd1"
$ZipDir = Join-Path ([IO.Path]::GetTempPath()) (Get-Random)
New-Item -ItemType "Directory" -Path $ZipDir | Out-Null 

$File = Join-Path $ZipDir "file.bin"
[IO.File]::WriteAllBytes($File, $Data)

$ZipFile = Join-Path ([IO.Path]::GetTempPath()) "file.zip"
Compress-Archive -Path $ZipDir  -DestinationPath $ZipFile -Force

New-PSUApiResponse -ContentType 'application/zip' -Data ([IO.File]::ReadAllBytes($ZipFile))
} 
New-PSUEndpoint -Url "/headers" -Method @('GET') -Endpoint {
$Headers
} 
New-PSUEndpoint -Url "/queryString" -Method @('GET') -Endpoint {
param($Query, $Page)

    $Query
    $Page
} 
New-PSUEndpoint -Url "/cookie" -Method @('GET') -Endpoint {
New-PSUApiResponse -Cookies @{
        MyCookie = 'Cookie'
    }
} 
New-PSUEndpoint -Url "/basic" -Method @('GET') -Endpoint {
$Headers
} -Authentication 
New-PSUEndpoint -Url "/secret" -Method @('GET') -Endpoint {
"Shhhh secret"
} -Authentication 
New-PSUEndpoint -Url "/random" -Method @('GET') -Endpoint {
$Val = Get-Random -Min 0 -Max 10  
    if ($Val -lt 8) {
        New-PSUApiResponse -StatusCode 400
    }
} 
New-PSUEndpoint -Url "/redirect" -Method @('GET') -Endpoint {
New-PSUApiResponse -StatusCode 301 -Headers @{
        Location = "http://localhost:5000/redirected"
    }
} 
New-PSUEndpoint -Url "/redirected" -Method @('GET') -Endpoint {
"Redirected!"
} 
New-PSUEndpoint -Url "/timeout" -Method @('GET') -Endpoint {
Start-Sleep 10
} 
New-PSUEndpoint -Url "/content/:type" -Method @('GET') -Endpoint {
param(
    [ValidateSet("json", "xml", 'text')]
    $Type
)

if ($Type -eq 'json') {
    New-PSUApiResponse -Body (@{
        "Hello" = "World"
    } | ConvertTo-Json) -ContentType 'application/json'
    
} elseif ($Type -eq 'xml') {
    New-PSUApiResponse -Body "<hello>world</hello>" -ContentType 'text/xml'
} else {
    New-PSUApiResponse -Body "Hello, world" -ContentType 'text/plain'
}
}
```