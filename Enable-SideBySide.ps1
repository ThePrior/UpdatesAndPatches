#
# See: https://docs.microsoft.com/en-us/sharepoint/upgrade-and-update/sharepoint-server-2016-zero-downtime-patching-steps#the-zdp-process
#

Add-PSSnapin Microsoft.SharePoint.PowerShell -EA Stop

[System.Collections.ArrayList]$webAppProps = @()

$webApps = Get-SPWebApplication 

foreach ($webApp in $webApps){
    if ($webapp.WebService.EnableSideBySide -ne $true){
        $webapp.WebService.EnableSideBySide = $true
        $webapp.WebService.update()
        }

    $webAppProp = [PSCustomObject]@{
        Name = $webApp.Name
        Url = $webApp.Url
        SideBySideEnabled = $webApp.WebService.EnableSideBySide
        }

    $webAppProps.Add($webAppProp) | Out-Null
    }
    
$webAppProps