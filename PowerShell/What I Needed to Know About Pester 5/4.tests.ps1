[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '', Scope='Function', Target='*')]
Param()

Import-Module "$PSScriptRoot\module.psm1"

Describe "Bananas" {
    BeforeAll {
        $Age = 7
    }
    Context "Rotten" {
        It "is rotten" {
            (Get-Banana -AgeDays $Age).Rotten | Should -Be $true
        }
    }
}