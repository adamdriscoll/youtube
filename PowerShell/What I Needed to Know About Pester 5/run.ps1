$pesterConfiguration = @{
    Run          = @{
        Path = @(".\")
    }
    Should       = @{
        ErrorAction = 'Continue'
    }
    CodeCoverage = @{
        OutputFormat   = 'JaCoCo'
        OutputEncoding = 'UTF8'
        OutputPath     = ".\Pester-Coverage.xml"
        Enabled        = $true
    }
    TestResult   = @{
        OutputPath     = ".\Pester-Test.xml"
        OutputFormat   = 'NUnitXml'
        OutputEncoding = 'UTF8'
        Enabled        = $true
    }
}

$config = New-PesterConfiguration -Hashtable $pesterConfiguration
Invoke-Pester -Configuration $config