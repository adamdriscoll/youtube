Import-Module "$PSScriptRoot\module.psm1"

Describe 'Bananas' {
    foreach ($age in 1..10) {
        It "is rotten at $number days" -TestCases @{'ageDays' = $age } {
            (Get-Banana -AgeDays $ageDays).Rotten | Should -Be ($ageDays -gt 5)
        }
    }
}