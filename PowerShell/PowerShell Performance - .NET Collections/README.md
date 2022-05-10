# [PowerShell Performance: .NET Collections](https://youtu.be/FXZLYKrbivY)


```powershell
using namespace System.Collections
using namespace System.Collections.Generic
using namespace System.Collections.Concurrent

# Array vs Lists
$a = @()
Measure-Command { 1..10000 | % { $a += $_ } }

$alist = [ArrayList]::new()
Measure-Command { 1..100000 | % { $alist.Add($_) | Out-Null } }
Measure-Command { $alist.Where({ $_ -eq 10000 }) }
Measure-Command { $alist.Contains(10000) }

$list = [List[int]]::new()
Measure-Command { 1..100000 | % { $list.Add($_) } }
Measure-Command { $list.Where({ $_ -eq 10000 }) }
Measure-Command { $list.Contains(10000) }

# Hash Sets
$array1 = 1..10000 | ForEach-Object { $_ * 2 }
$array2 = 1..10000 | ForEach-Object { ($_ * 2) + 1 }
$array3 = @()
Measure-Command { $array3 = ($array1 + $array2) | Select-Object -Unique }
$array3.Count

$OddSet = [Hashset[int]]::new()
$EvenSet = [Hashset[int]]::new()

1..100000 | % { 
    $EvenSet.Add($_ * 2) | Out-Null
    $OddSet.Add(($_ * 2) + 1) | Out-Null
}

$EvenSet.Count
$OddSet.Count

$NewSet = [Hashset[int]]::new($EvenSet)
Measure-Command { $NewSet.UnionWith($OddSet) }
$NewSet.Count

# Sorted List
$Randoms = Get-Random -Count 100000
Measure-Command { $Randoms | Sort-Object }

$l = [List[int]]::new()
$Randoms | ForEach-Object { $l.Add($_) }

Measure-Command { 
    $l.Sort() 
}


# Concurrent Queue
Measure-Command { 1..1000 | ForEach-Object -Parallel {
        $_ * 2
    } -ThrottleLimit 5
}

$ConcurrentQueue = [ConcurrentQueue[int]]::new()
1..100000 | ForEach-Object { $ConcurrentQueue.Enqueue($_) } 
$ConcurrentQueue.Count
    
Measure-Command {
    1..5  | ForEach-Object {
        Start-ThreadJob {
            $i = $null 
            while ($args[0].TryPeek([ref]$i)) {
                if ($args[0].TryDequeue([ref]$i)) {
                    $i * 2
                }
            }
        } -ArgumentList $ConcurrentQueue
    } | Wait-Job | Receive-Job
}

# Concurrency

$ConcurrentQueue = [ConcurrentQueue[int]]::new()
1..100000 | ForEach-Object { $ConcurrentQueue.Enqueue($_) } 
$ConcurrentQueue.Count

Start-ThreadJob {
    while ($args[0].Count -lt 200000) {
        $args[0].Enqueue((Get-Random))
    }
} -ArgumentList $ConcurrentQueue
    
Measure-Command {
    1..5  | ForEach-Object {
        Start-ThreadJob {
            $i = $null 
            while ($args[0].Count -gt 0) {
                if ($args[0].TryDequeue([ref]$i)) {
                    $i * 2
                }
            }
        } -ArgumentList $ConcurrentQueue
    } | Wait-Job
}

```