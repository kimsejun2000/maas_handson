New-Item -Path "C:\" -Name Temp -ItemType directory
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/kimsejun2000/maas_handson/main/script/set-environmentvhdx.ps1" -OutFile "C:\Temp\set-environmentvhdx.ps1"

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Unrestricted -file C:\Temp\set-environmentvhdx.ps1"
$delayTime = new-timespan -Minutes 1
$trigger = New-ScheduledTaskTrigger -AtStartup -RandomDelay $delayTime
$principal = New-ScheduledTaskPrincipal -UserId "ubucon" -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet
$task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings
Register-ScheduledTask initenv -InputObject $task

Install-WindowsFeature -Name hyper-v -IncludeAllSubFeature -IncludeManagementTools -Restart