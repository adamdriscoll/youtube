Import-Module "$PSScriptRoot\module.psm1"

Describe "Bananas" {
    Context "Rotten" {
        It "is rotten" {
            (Get-Banana -AgeDays 10).Rotten | Should -Be $true
        }
    }
}