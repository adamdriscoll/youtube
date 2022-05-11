# [PowerShell Performance: Strings and String Builder](https://youtu.be/W5stxz96FO0)

```powershell
using namespace System.Text 

Measure-Command {
    $sb = [StringBuilder]::new()
    1..100000 | ForEach-Object {
        $null = $sb.Append("Hello")
    }
    $null = $sb.ToString()
}

Measure-Command {
    $s = ''
    1..100000 | ForEach-Object {
        $s += 'Hello'
    }
}

$sb = [StringBuilder]::new()
$world = "World"
$sb.AppendFormat("Hello, {0}", $world) | Out-Null
$sb.ToString()

$sb = [StringBuilder]::new()
$sb.Append("World") | Out-Null
$sb.Insert(0, "Hello, ") | Out-Null
$sb.ToString()

(gps -id $pid).PM / 1mb

$s = ''
1..100000 | ForEach-Object {
    $s += 'Hello'
}

$s1 = ''
1..100000 | ForEach-Object {
    $s1 += 'Hello'
}

(gps -id $pid).PM / 1mb

[GC]::Collect()
(gps -id $pid).PM / 1mb
```