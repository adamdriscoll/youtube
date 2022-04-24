function Get-Banana {
    param($AgeDays)

    @{
        AgeDays = $AgeDays
        Rotten  = $AgeDays -gt 5
    }
}