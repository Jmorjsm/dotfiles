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

# Copy the current working directory path
function cpwd()
{
    $(pwd).path | clip
}

# Helper function for removing and recreating the most-recently added EF migration.
function RecreateMigration() {
    # Get all migration names
    $migrationNames = (dotnet ef migrations list)
    
    # Get the migration we should go back to (the one before the one we've added)
    $migrationToRevertTo = $migrationNames[($migrationNames.length - 2)]
    
    # Get the migration name we want to recreate
    $migrationToRecreate = $migrationNames[($migrationNames.length - 1)]
    
    # Trim first 15 characters (date and underscore) 20220124114814_AddMyTables
    $migrationToRecreateTrimmedName = $migrationToRecreate.Substring(15)

    # Migrate to the previous migration
    dotnet ef database update $migrationToRevertTo

    # Get rid of the migration we're recreating
    dotnet ef migrations remove
    
    # Create the migration again
    dotnet ef migrations add $migrationToRecreateTrimmedName
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

# Environment variables
$env:TZ_LIST = "US/Pacific,Pacific;US/Eastern,Eastern;Europe/Warsaw,Warsaw;Australia/Sydney,Sydney"

Set-Location ~
Clear-Host
