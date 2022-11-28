# Download disk file for maas VM
New-Item -Path "C:\" -Name VM -ItemType directory
New-Item -Path "C:\VM\" -Name Disk -ItemType directory

Invoke-WebRequest -Uri "https://ubuconmasstemplate.blob.core.windows.net/vmdisk/maas.vhdx?sp=r&st=2022-11-28T06:38:25Z&se=2022-11-28T14:38:25Z&spr=https&sv=2021-06-08&sr=b&sig=IStaaIghY5NxY%2FVfOS89FH81JUAJu3rS1%2F8hyBRxBbw%3D" -OutFile "C:\VM\Disk\maas.vhdx"

# Create Virtual Network
New-VMSwitch -Name Internal -SwitchType Internal

# Create VMs
New-Item -Path "C:\" -Name VM -ItemType directory

New-VM -Name maas -MemoryStartupBytes 2GB -VHDPath "C:\VM\Disk\maas.vhdx" -Generation 2 -SwitchName Internal -Path "C:\VM\"
Set-VMFirmware -VMName maas -SecureBootTemplate MicrosoftUEFICertificateAuthority
Set-VMProcessor -VMName maas -Count 2
Set-VMNetworkAdapter -VMName maas -StaticMacAddress "00155DFF0401"

New-VM -Name deployhost -MemoryStartupBytes 4GB -NewVHDPath "C:\VM\Disk\deployhost.vhdx" -NewVHDSizeBytes 20GB -Generation 2 -SwitchName Internal -Path "C:\VM\"
Set-VMProcessor -VMName deployhost -Count 4
Set-VMFirmware -VMName deployhost -SecureBootTemplate MicrosoftUEFICertificateAuthority
Set-VMNetworkAdapter -VMName deployhost -StaticMacAddress "00155DFF0402"

Unregister-ScheduledTask initenv -Confirm:$false