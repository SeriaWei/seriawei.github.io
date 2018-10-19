Add-Type -AssemblyName System.IO.Compression.FileSystem
Import-Module WebAdministration
$WebPath=[environment]::CurrentDirectory + "\ZKEACMS";
Write-Host "Welcome to use ZKEACMS, visit our website(http://www.zkea.net) for more information"
Write-Host "ZKEACMS will install to $WebPath"
Write-Host "After installation, you can visit the site with http://localhost:8080"
Write-Host "Installation started. Press Ctrl+C to stop."

Write-Host "Checking IIS status..."
$iis = Get-Service W3SVC -ErrorAction Ignore
if($iis){
    if($iis.Status -eq "Running") {
        Write-Host "IIS Service is running"
    }
    else {
        Write-Host "IIS Service is not running"
    }
}
else {
	Write-Host "Checking IIS failed, please make sure IIS is ready."	
}
$aspNetCoreModule = Get-WebGlobalModule -Name AspNetCoreModule -ErrorAction Ignore
if($aspNetCoreModule)
{
	Write-Host "IIS ASPNetCoreModule is ready:"
	Write-Host $aspNetCoreModule.Name $aspNetCoreModule.Image 
}
else
{
	Write-Host "Downloading DotNetCore.WindowsHosting."
	if(Test-Path -Path "DotNetCore.WindowsHosting.exe")
	{
		Remove-Item -Path "DotNetCore.WindowsHosting.exe" -Force
	}
	Invoke-WebRequest -Uri "https://download.visualstudio.microsoft.com/download/pr/86df96bb-384c-4d7a-82ce-2e4c2c871189/045870c1ab4004219cb312039c5a64d5/dotnet-hosting-2.1.5-win.exe" -OutFile "DotNetCore.WindowsHosting.exe"
	
	Write-Host "Installing DotNetCore.WindowsHosting."
	Start-Process "DotNetCore.WindowsHosting.exe" -Wait
	if(Test-Path -Path "DotNetCore.WindowsHosting.exe")
	{
		Remove-Item -Path "DotNetCore.WindowsHosting.exe" -Force
	}
}

Write-Host "Downloading ZKEACMS application package."
if(Test-Path -Path "ZKEACMS.zip")
{
	Remove-Item -Path "ZKEACMS.zip" -Force
}
Invoke-WebRequest -Uri "http://zkeasoft-10041459.file.myqcloud.com/core/cms.zip" -OutFile "ZKEACMS.zip"

Write-Host "Unzip ZKEACMS application package."
if(Test-Path "ZKEACMS")
{
	Remove-Item -Path "ZKEACMS" -Force -Recurse
}
[System.IO.Compression.ZipFile]::ExtractToDirectory("ZKEACMS.zip" ,"ZKEACMS")

Write-Host "Setting up IIS."
if(!(Test-Path IIS:\AppPools\ZKEACMS))
{
	New-Item -path IIS:\AppPools\ZKEACMS
}
Set-ItemProperty -Path IIS:\AppPools\ZKEACMS -Name managedRuntimeVersion -Value ''
if(Test-Path IIS:\Sites\ZKEACMS)
{
	Remove-Website ZKEACMS
}
New-Website -name ZKEACMS -PhysicalPath $WebPath -ApplicationPool ZKEACMS -Port 8080
Invoke-Expression "net stop was /y"
Invoke-Expression "net start w3svc"
Invoke-Expression "cmd.exe /C start http://localhost:8080"
if(Test-Path -Path "ZKEACMS.zip")
{
	Remove-Item -Path "ZKEACMS.zip" -Force
}
Write-Host "ZKEACMS installed successfully."
