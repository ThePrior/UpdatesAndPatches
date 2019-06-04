
cd $PSScriptRoot
$timeStamp = (Get-Date).ToString("yyyy-MM-dd")
$scriptName = $MyInvocation.MyCommand.Name


Start-Transcript -Path ".\$scriptName-$($timeStamp).log" -Append

Write-Host "`n"
Disable-ScheduledTask -TaskName 'SPBestWarmUp'
Write-Host "`n"

cd 'c:\Program Files\Common Files\Microsoft Shared\web server extensions\16\bin'

PSConfig.exe -cmd upgrade -inplace b2b -wait -cmd applicationcontent -install -cmd installfeatures -cmd secureresources

Write-Host "`n"
Enable-ScheduledTask -TaskName 'SPBestWarmUp'
Write-Host "`n"

Stop-Transcript