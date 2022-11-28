# Download image for Ubuneu 22.04 iso
Invoke-WebRequest -Uri https://mirror.textcord.xyz/ubuntu-releases/22.04.1/ubuntu-22.04.1-live-server-amd64.iso -OutFile $env:USERPROFILE\Downloads\ubuntu-22.04.1-live-server-amd64.iso

# Create Virtual Network
New-VMSwitch -Name Internal -SwitchType Internal

# Create VMs
New-Item -Path "C:\" -Name VM -ItemType directory

New-VM -Name maas -MemoryStartupBytes 2GB -NewVHDPath "C:\VM\Disk\maas.vhdx" -NewVHDSizeBytes 20GB -Generation 2 -SwitchName Internal -Path "C:\VM\"
Set-VMProcessor -VMName maas -Count 2
Add-VMDvdDrive -VMName maas -Path $env:USERPROFILE\Downloads\ubuntu-22.04.1-live-server-amd64.iso
$vmDVDDrive = Get-VMDvdDrive -VMName maas
Set-VMFirmware -VMName maas -SecureBootTemplate MicrosoftUEFICertificateAuthority -FirstBootDevice $vmDVDDrive
Set-VMNetworkAdapter -VMName maas -StaticMacAddress "00155DFF0401"

New-VM -Name deployhost -MemoryStartupBytes 4GB -NewVHDPath "C:\VM\Disk\deployhost.vhdx" -NewVHDSizeBytes 20GB -Generation 2 -SwitchName Internal -Path "C:\VM\"
Set-VMProcessor -VMName deployhost -Count 4
Set-VMFirmware -VMName deployhost -SecureBootTemplate MicrosoftUEFICertificateAuthority
Set-VMNetworkAdapter -VMName deployhost -StaticMacAddress "00155DFF0402"