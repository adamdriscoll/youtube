Import-Module "$PSScriptRoot\module.psm1"

Write-Host "Discovery"
Describe "Bananas" {
    Write-Host "Discovery"
    Context "Rotten" {
        Write-Host "Discovery"
        It "is rotten" {
            Write-Host "Run"
            (Get-Banana -AgeDays 10).Rotten | Should -Be $true
        }
    }
}