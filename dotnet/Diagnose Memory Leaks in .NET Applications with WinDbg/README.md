# [Diagnose Memory Leaks in .NET Applications with WinDbg](https://youtu.be/V-bbGIb1cEo)

Commands Run During this Video

```
.loadby sos coreclr
!DumpHeap -stat
!DumpHeap -type System.String -min 500000
!DumpObj /d 00000197894a8fc8
!gcroot 00000197894a8fc8
!DumpObj /d 00000198D3F02FA8
!DumpObj /d 00000198d3f02eb0
```