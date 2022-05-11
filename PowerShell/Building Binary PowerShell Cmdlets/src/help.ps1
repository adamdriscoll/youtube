New-ExternalHelp -Path .\help -OutputPath .\bin\Debug\netstandard2.0\publishImport-Module "$PSScriptRoot\bin\Debug\netstandard2.1\publish\PSHtml.dll"
New-MarkdownHelp -Module PSHtml -OutputFolder "$PSScriptRoot\help"
New-ExternalHelp -Path .\help -OutputPath .\bin\Debug\netstandard2.0\publish