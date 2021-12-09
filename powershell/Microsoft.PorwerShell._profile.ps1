# Aliases
Set-Alias -Name open -Value explorer
Set-Alias -Name which -Value Get-Command
Set-Alias -Name touch -value "New-Item -itemtype file"
Set-Alias -Name clob -value "Get-ChildItem .\ -include bin,obj -Recurse | foreach ($_) { remove-item $_.fullname -Force -Recurse }"

# posh-git
Import-Module posh-git
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
$GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "dd-MM HH:mm:ss")'
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Cyan

# fzf completion
Import-Module PSReadline
Import-Module psfzf
Set-PsFzfOption -TabExpansion
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -psReadlineChordReverseHistory 'Ctrl+r'
Set-PsReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# docker autocompletion
#Install-Module DockerCompletion -Scope CurrentUser
Import-Module DockerCompletion

# gh cli completions
Invoke-Expression (@(gh completion --shell powershell) -replace " ''\)$"," ' ')" -join "`n")

# Git global configs
git config --global core.excludesfile ~/.gitignore
git config --global push.default current

# Powershell functions/aliases
# quickly cd to folder
function dev {
    Set-Location "~/dev"
}

# tidy LS command, without all the indentation
function lsl($fp)
{
    gci $fp | foreach-object {write-output "$(if ($_.PSIsContainer) {"D"} else {"F"})|$($_.Name)"}
}

# delete all bin and obj files (for fixing broken c# projects)
function clobj($fp)
{
    Get-childitem $fp -include bin,obj -recurse | foreach ($_) { remove-item $_.fullname -force -recurse }
}

Set-Location ~
Clear-Host
