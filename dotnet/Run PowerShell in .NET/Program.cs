using System.Management.Automation;

using var ps = PowerShell.Create();

try
{
    var result = ps.AddCommand("Get-Process").Invoke<System.Diagnostics.Process>();
    if (ps.HadErrors)
    {
        foreach (var error in ps.Streams.Error)
        {
            Console.WriteLine(error.ToString());
        }
    }
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message);
}

Console.ReadLine();
