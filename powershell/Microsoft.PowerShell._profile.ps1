# Aliases
Set-Alias -Name open -Value explorer
Set-Alias -Name which -Value Get-Command

# Powershell functions/aliases
# quickly cd to folder
function dev {
    Set-Location "~/dev"
}

# tidy LS command, without all the indentation
function lsl($path)
{
    Get-ChildItem $path | foreach-object {write-output "$(if ($_.PSIsContainer) {"D"} else {"F"})|$($_.Name)"}
}

# create a new file at with the given file name(same as unix)
function touch($path)
{
    New-Item -itemtype file -Path $path
}

# delete all bin and obj files (for fixing broken c# projects)
function clobj($path)
{
    Get-childitem $path -include bin,obj -recurse | ForEach-Object ($_) { remove-item $_.fullname -force -recurse }
}

# posh-git
Import-Module posh-git
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
$GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "dd-MM HH:mm:ss") '
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Cyan

# fzf completion
Import-Module PSReadline
Import-Module psfzf
Set-PsFzfOption -TabExpansion
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -psReadlineChordReverseHistory 'Ctrl+r'
Set-PsReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# docker autocompletion
Import-Module DockerCompletion

# gh cli completions
Invoke-Expression (@(gh completion --shell powershell) -replace " ''\)$"," ' ')" -join "`n")

Set-Location ~
Clear-Host
