# Set PSRepository so we shouldn't have to confirm every install-module statement
Set-PSRepository PSGallery -InstallationPolicy Trusted

# Install choco
Write-Output "`tInstalling chocolatey"
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install posh-git
Write-Output "`tInstalling posh-git"
Install-Module posh-git

# Install docker autocomplete
Write-Output "`tInstalling DockerCompletion"
Install-Module DockerCompletion -Scope CurrentUser

# Install fzf, psreadline, psfzf
Write-Output "`tInstalling fzf, psreadline, psfzf"
choco install fzf
Install-Module PSReadLine -AllowPrerelease -Force
Install-Module PSFzf

# Copy the powershell profile
Write-Output "`tCopying Microsoft.PowerShell._profile.ps1 to PowerShell config folder..."
Copy-ItemWithBackup "Microsoft.PowerShell._profile.ps1" $PROFILE
