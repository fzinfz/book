<!-- TOC -->

- [Basic](#basic)
- [list top processes sort by memory](#list-top-processes-sort-by-memory)
- [sum memory of all processes](#sum-memory-of-all-processes)
- [list and grep process members](#list-and-grep-process-members)
- [query process by WMI](#query-process-by-wmi)

<!-- /TOC -->

# Basic

    Set-ExecutionPolicy RemoteSigned
    Enable-PSRemoting -Force

    Import-Module ServerManager
    Add-WindowsFeature RDS-Virtualization

#list top processes sort by memory
    Get-Process | Sort WorkingSet -Descending  | select-object  Id, Name, 
    @{Name='WorkingSet(Mb)';Expression={"{0:N2}" -f ($_.WorkingSet / 1Mb)}}, 
    @{Name='PrivateMemorySize(Mb)';Expression={"{0:N2}" -f ($_.PrivateMemorySize / 1Mb)}}, 
    @{Name='PM(Mb)';Expression={"{0:N2}" -f ($_. PM/ 1Mb)}}, 
    @{Name='NPM(Mb)';Expression={"{0:N2}" -f ($_. NPM/ 1Mb)}}  `
    -First 10 | Format-Table

#sum memory of all processes
    Get-Process  | measure-object -sum 'PrivateMemorySize', PM,NPM,WS  |  
    select-object  @{Name='Sum(Gb)';Expression={"{0:N2}" -f ($_.sum / 1Gb  ) }  } ,count, Property

#list and grep process members
    Get-Process | Get-Member | findstr Mem

#query process by WMI
    Get-WMIObject Win32_Process
