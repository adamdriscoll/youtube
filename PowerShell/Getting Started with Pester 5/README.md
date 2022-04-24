# [Getting Started with Pester 5]()

Published: 4/25/2022

## Install

```powershell
Install-Module Pester -RequiredVersion 5.0.0
```

## Author Tests

```powershell
function Get-Banana {
    param($AgeDays)

    @{
        AgeDays = $AgeDays
        Rotten = $AgeDays -gt 5
    }
}
```

```powershell
Describe "Bananas" {
    Context "Rotten" {
        It "is rotten" {
            (Get-Banana -AgeDays 10).Rotten | Should -be $true
        }
    }
}
```

### Discovery vs Run

```powershell
Write-Host "Discovery"
Describe "Bananas" {
    Write-Host "Run"
    Context "Rotten" {
        It "is rotten" {
            (Get-Banana -AgeDays $Age).Rotten | Should -be $true
        }
    }
}
```

### Initialization (Bad)

```powershell
$Age = 7
Describe "Bananas" {
    Context "Rotten" {
        It "is rotten" {
            (Get-Banana -AgeDays $Age).Rotten | Should -be $true
        }
    }
}
```

### Initialization (Good)

```powershell
Describe "Bananas" {
    BeforeAll {
        $Age = 7
    }
    Context "Rotten" {
        It "is rotten" {
            (Get-Banana -AgeDays $Age).Rotten | Should -be $true
        }
    }
}
```

### Pester Configuration 

```powershell
$pesterConfiguration = @{
    Run = @{
        Path = @(".\tests")
    }
    Should = @{
        ErrorAction = 'Continue'
    }
    CodeCoverage = @{
        OutputFormat = 'JaCoCo'
        OutputEncoding = 'UTF8'
        OutputPath = ".\Pester-Coverage.xml"
        Enabled = $true
    }
    TestResult = @{
        OutputPath = ".\Pester-Test.xml"
        OutputFormat = 'NUnitXml'
        OutputEncoding = 'UTF8'
        Enabled = $true
    }
}
$config = New-PesterConfiguration -Hashtable $pesterConfiguration
Invoke-Pester -Configuration $config
```

### Test Cases

```powershell
Describe 'Bananas' {
    foreach ($age in 1..10) {
        It "is rotten at $number days" -TestCases @{'ageDays' = $age} {
            Get-Banana -AgeDays $ageDays | Should -be ($ageDays -gt 5)
        }
    }
}
```