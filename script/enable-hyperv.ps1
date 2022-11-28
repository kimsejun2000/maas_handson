New-Item -Path "C:\" -Name Temp -ItemType directory
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/kimsejun2000/maas_handson/main/script/set-environmentvhdx.ps1" -OutFile "C:\Temp\set-environmentvhdx.ps1"

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Unrestricted -file C:\Temp\set-environmentvhdx.ps1"
$trigger = New-ScheduledTaskTrigger -AtStartup
$principal = New-ScheduledTaskPrincipal -UserId "S-1-5-21-1980097976-1178934822-2883624732-500" -LogonType S4U -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet
$task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings
Register-ScheduledTask initenv -InputObject $task

Install-WindowsFeature -Name hyper-v -IncludeAllSubFeature -IncludeManagementTools -Restart