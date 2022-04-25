Import-Module "$PSScriptRoot\module.psm1"

$Age = 7
Describe "Bananas" {
    Context "Rotten" {
        It "is rotten" {
            (Get-Banana -AgeDays $Age).Rotten | Should -Be $true
        }
    }
}