$gitConfigFileName = ".gitconfig"
$gitConfigOutputFileName = "$Env:USERPROFILE\$gitConfigFileName"

$gitConfigCoreExcludesFileName = "$Env:USERPROFILE\.gitignore"

Write-Output "`tCopying .gitignore to user home directory."
Copy-ItemWithBackup ".gitignore" $gitConfigCoreExcludesFileName

$gitConfigUserEmail = Read-Host -Prompt "git config user email"
$gitConfigUserName = Read-Host -Prompt "git config user name"

Write-Output "`tCopying .gitconfig to user home directory."

New-FileBackup $gitConfigFileName $gitConfigOutputFileName
((Get-Content -Path $gitConfigFileName -Raw) `
    -replace '$(GitConfigCoreExcludesFileName)', $GitConfigCoreExcludesFileName `
    -replace '$(GitConfigUserEmail)', $GitConfigUserEmail `
    -replace '$(GitConfigUserName)', $GitConfigUserName) `
    | Set-Content -path $gitConfigOutputFileName
