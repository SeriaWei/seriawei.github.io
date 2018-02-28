
Invoke-WebRequest -Uri "https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe" -OutFile "$PSScriptRoot\vc_redist.x64.exe"
Invoke-WebRequest -Uri "https://aka.ms/dotnetcore.2.0.0-windowshosting" -OutFile "$PSScriptRoot\DotNetCore.WindowsHosting.exe"
Start-Process "$PSScriptRoot\vc_redist.x64.exe" -Wait 
Start-Process "$PSScriptRoot\DotNetCore.WindowsHosting.exe" -Wait

set-executionpolicy remotesigned
Import-Module WebAdministration
New-Item -path IIS:\AppPools\ZKEACMS
Set-ItemProperty -Path IIS:\AppPools\ZKEACMS -Name managedRuntimeVersion -Value ''
New-Website -name ZKEACMS -PhysicalPath F:\DotNetCore\ZKEACMS -ApplicationPool ZKEACMS
Write-Output "Time taken:"