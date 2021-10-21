$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$helpers = Join-Path $toolsDir 'helpers.ps1'
. $helpers

$JavaHome = Get-JavaHome
Write-Host "Detected Java at: $JavaHome"

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'msi'
    file          = Join-Path -Path $toolsDir -ChildPath 'jenkins.msi'
    silentArgs    = "/qn /norestart /l `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" SERVICE_LOGON_TYPE=ServiceLocalSystem SERVICE_DISPLAY_USERNAME=LocalSystem" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
    validExitCodes= @(0, 3010, 1641)
    softwareName  = 'Jenkins*'
}

if(-not $env:JAVA_HOME){
    $packageArgs.silentArgs = "/qn /norestart /l `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" SERVICE_LOGON_TYPE=ServiceLocalSystem SERVICE_DISPLAY_USERNAME=LocalSystem JAVA_HOME=`"$JavaHome`""
}
