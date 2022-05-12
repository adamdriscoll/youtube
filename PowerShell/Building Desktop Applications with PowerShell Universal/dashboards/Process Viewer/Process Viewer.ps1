New-UDDashboard -Title 'Services' -Content {
    $ErrorActionPreference = 'SilentlyContinue'
    New-UDTable -Data (Get-Service) -Columns @(
        New-UDTableColumn -Property 'Name'
        New-UDTableColumn -Property 'Status'
    ) -ShowPagination
}