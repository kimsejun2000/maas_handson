Install-WindowsFeature -Name hyper-v -IncludeAllSubFeature -IncludeManagementTools -Restart

Invoke-WebRequest -Uri 

$action = New-ScheduledTaskAction -Execute "powershell -ExecutionPolicy Unrestricted"
$trigger = New-ScheduledTaskTrigger -AtLogon
$principal = "ubucon"
$settings = New-ScheduledTaskSettingsSet
$task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings
Register-ScheduledTask T1 -InputObject $task


git config --global user.email "you@example.com"
git config --global user.name "Sejun Kim"