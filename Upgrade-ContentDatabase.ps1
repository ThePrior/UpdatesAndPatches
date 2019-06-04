
#
# Fixes: "Database is in compatibility range and upgrade is recommended" issue in http://localhost:2016/_admin/DatabaseStatus.aspx
#
# See: https://social.technet.microsoft.com/wiki/contents/articles/47921.sharepoint-2016-databases-running-in-compatibility-range-upgrade-recommended.aspx
#

cd $PSScriptRoot
$timeStamp = (Get-Date).ToString("yyyy-MM-dd")
$scriptName = $MyInvocation.MyCommand.Name
Start-Transcript -Path ".\$scriptName-$($timeStamp).log" -Append

cd 'c:\Program Files\Common Files\Microsoft Shared\web server extensions\16\bin'

PSConfig.exe -cmd upgrade -inplace b2b -wait

Stop-Transcript