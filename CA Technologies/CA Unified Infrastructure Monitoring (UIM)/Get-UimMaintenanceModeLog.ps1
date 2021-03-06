Function Get-UimMaintenanceModeLog
{
    <#
.SYNOPSIS
Gets the UIM Maintenance Mode logs generated by the Cmdlets Start-UimMaintenanceMode, Stop-UimMaintenanceMode and Set-UimMaintenanceMode and displays an overview.

Beware: It does not get the info from UIM directly and therefore it will only include actions initiated using the PowerShell cmdlets described above and only when executed from a system that can reach the logfile. Therefore it is likely that it is not complete.

.DESCRIPTION
Gets the UIM Maintenance Mode logs generated by the Cmdlets Start-UimMaintenanceMode, Stop-UimMaintenanceMode and Set-UimMaintenanceMode and displays an overview.

Beware: It does not get the info from UIM directly and therefore it will only include actions initiated using the PowerShell cmdlets described above and only when executed from a system that can reach the logfile. Therefore it is likely that it is not complete.

The added value of this over getting the info from UIM directly is that it provides more details about who did what, when and why which the nimalarm.exe method does not provide without the PowerShell wrapper cmdlets.

.EXAMPLE

Get-UimMaintenanceModeLog | Format-Table

.NOTES
To improve  :  Add example with how to send the result by mail.
NAME        :  Get-UimMaintenanceModeLog
VERSION     :  1.0   
LAST UPDATED:  2019-03-27
AUTHOR      :  Bjorn Houben (bjorn@bjornhouben.com)

  ****************************************************************
  * DO NOT USE IN A PRODUCTION ENVIRONMENT UNTIL YOU HAVE TESTED *
  * THOROUGHLY IN A LAB ENVIRONMENT. USE AT YOUR OWN RISK.  IF   *
  * YOU DO NOT UNDERSTAND WHAT THIS SCRIPT DOES OR HOW IT WORKS, *
  * DO NOT USE IT OUTSIDE OF A SECURE, TEST SETTING.             *
  ****************************************************************

.INPUTS
None

.OUTPUTS
[object]
#>
    BEGIN
    {
        $Filepath = '\\fileshare.domain.local\repository\PowerShellLogging\Set-UimMaintenanceMode\Set-UimMaintenanceMode_log.csv'
        TRY
        {
            Test-Path -Path $Filepath -ErrorAction Stop
            $FileReachable = $True
        }
        CATCH
        {
            $FileReachable = $False
        }
        FINALLY
        {
        }
    }
    PROCESS
    {
        IF ($FileReachable)
        {
            Import-Csv -Path $Filepath -Delimiter ',' | Sort-Object InitDate, InitTime -Descending | Select-Object InitDate, InitTime, Action, Computer, MaintEndDate, MaintEndTime, InitBy, Reason
        }
        ELSE
        {
            Write-Output "File $Filepath was not reachable"
            $Error[0]
        }
    }
    END
    {
    }
}