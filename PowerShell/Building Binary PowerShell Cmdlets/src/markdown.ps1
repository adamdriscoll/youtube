Import-Module "$PSScriptRoot\bin\Debug\netstandard2.0\publish\PSHtml.dll"
New-MarkdownHelp -Module PSHtml -OutputFolder "$PSScriptRoot\help"
