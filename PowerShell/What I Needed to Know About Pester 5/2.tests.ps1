Import-Module "$PSScriptRoot\module.psm1"

Write-Host "Discovery"
Describe "Bananas" {
    BeforeAll {
        Write-Host "Run (BeforeAll)"
    }
    AfterAll {
        Write-Host "Run (AfterAll)"
    }
    BeforeEach {
        Write-Host "Run (BeforeEach)"
    }
    AfterEach {
        Write-Host "Run (AfterEach)"
    }
    
    Write-Host "Discovery"
    Context "Rotten" {
        Write-Host "Discovery"
        It "is rotten" {
            Write-Host "Run"
            (Get-Banana -AgeDays 10).Rotten | Should -Be $true
        }
        It "is not rotten" {
            Write-Host "Run"
            (Get-Banana -AgeDays 1).Rotten | Should -Be $false
        }
    }
}