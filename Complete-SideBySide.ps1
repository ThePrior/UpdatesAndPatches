#
# See: https://docs.microsoft.com/en-us/sharepoint/upgrade-and-update/sharepoint-server-2016-zero-downtime-patching-steps#the-zdp-process
#

Add-PSSnapin Microsoft.SharePoint.PowerShell -EA Stop

cd $PSScriptRoot
$timeStamp = (Get-Date).ToString("yyyy-MM-dd")
$scriptName = $MyInvocation.MyCommand.Name
Start-Transcript -Path ".\$scriptName-$($timeStamp).log" -Append

$buildNumber = '16.0.4849.1000'

[System.Collections.ArrayList]$webAppProps = @()

$webApps = Get-SPWebApplication 

foreach ($webApp in $webApps){
    $webapp.WebService.SideBySideToken = $buildNumber
    $webapp.WebService.update()


    $webAppProp = [PSCustomObject]@{
        Name = $webApp.Name
        Url = $webApp.Url
        SideBySideEnabled = $webApp.WebService.EnableSideBySide
        SideBySideToken = $webapp.WebService.SideBySideToken
        }

    $webAppProps.Add($webAppProp) | Out-Null
    }
    
$webAppProps

Stop-Transcript