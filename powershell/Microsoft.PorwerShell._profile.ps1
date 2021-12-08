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
# quickly cd to folder
function dev {
    Set-Location "~/dev"
}

# gh cli completions
Invoke-Expression (@(gh completion --shell powershell) -replace " ''\)$"," ' ')" -join "`n")

# Git global configs
git config --global core.excludesfile ~/.gitignore
git config --global push.default current

Set-Location ~
Clear-Host
