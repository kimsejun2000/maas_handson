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