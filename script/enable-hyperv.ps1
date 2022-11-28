Install-WindowsFeature -Name hyper-v -IncludeAllSubFeature -IncludeManagementTools -Restart

New-Item -Path "C:\" -Name Temp -ItemType directory
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/kimsejun2000/maas_handson/main/script/set-environmentvhdx.ps1" -OutFile "C:\Temp\set-environmentvhdx.ps1"

$action = New-ScheduledTaskAction -Execute "powershell -ExecutionPolicy Unrestricted -file C:\Temp\set-environmentvhdx.ps1"
$trigger = New-ScheduledTaskTrigger -AtLogon
$principal = "ubucon"
$settings = New-ScheduledTaskSettingsSet
$task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings
Register-ScheduledTask T1 -InputObject $task