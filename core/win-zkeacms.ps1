Add-Type -AssemblyName System.IO.Compression.FileSystem
Import-Module WebAdministration
if(!(Get-Command dotnet -ErrorAction SilentlyContinue))
{
	Write-Host "Download DotNetCore.WindowsHosting."
	#Invoke-WebRequest -Uri "https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe" -OutFile "vc_redist.x64.exe"
	Invoke-WebRequest -Uri "https://aka.ms/dotnetcore.2.0.0-windowshosting" -OutFile "DotNetCore.WindowsHosting.exe"
	#Start-Process "vc_redist.x64.exe" -Wait 
	Start-Process "DotNetCore.WindowsHosting.exe" -Wait

	#Remove-Item -Path "vc_redist.x64.exe" -Force 
	Remove-Item -Path "DotNetCore.WindowsHosting.exe" -Force
}
if(Test-Path -Path "ZKEACMS.zip")
{
	Remove-Item -Path "ZKEACMS.zip" -Force
}
Write-Host "Download ZKEACMS application package."
Invoke-WebRequest -Uri "http://cdn.zkeasoft.com/core/cms.zip" -OutFile "ZKEACMS.zip"
if(Test-Path "ZKEACMS")
{
	Remove-Item -Path "ZKEACMS" -Force -Recurse
}
Write-Host "Unzip ZKEACMS application package."
[System.IO.Compression.ZipFile]::ExtractToDirectory("ZKEACMS.zip" ,"ZKEACMS")
#set-executionpolicy remotesigned
if(!(Test-Path IIS:\AppPools\ZKEACMS))
{
	New-Item -path IIS:\AppPools\ZKEACMS
}
Set-ItemProperty -Path IIS:\AppPools\ZKEACMS -Name managedRuntimeVersion -Value ''
if(Test-Path IIS:\Sites\ZKEACMS)
{
	Remove-Website ZKEACMS
}
New-Website -name ZKEACMS -PhysicalPath $PSScriptRoot\ZKEACMS -ApplicationPool ZKEACMS -Port 8080
Invoke-Expression "cmd.exe /C start http://localhost:8080"