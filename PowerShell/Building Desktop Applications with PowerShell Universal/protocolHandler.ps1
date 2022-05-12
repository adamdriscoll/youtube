param($ProtocolUri)

$Page = $ProtocolUri.Replace("psu://", "")
$Page
Show-PSUPage -Url $Page