$gitConfigFileName = ".gitconfig"
$gitConfigOutputFileName = Join-Path $Env:USERPROFILE $gitConfigFileName

$gitConfigCoreExcludesFileName = Join-Path $Env:USERPROFILE ".gitignore"

Write-Output "`tCopying .gitignore to user home directory."
Copy-ItemWithBackup ".gitignore" $gitConfigCoreExcludesFileName

$gitConfigCoreExcludesFileName = $gitConfigCoreExcludesFileName.Replace("\", "\\")

$gitConfigUserEmail = Read-Host -Prompt "git config user email"
$gitConfigUserName = Read-Host -Prompt "git config user name"

Write-Output "`tCopying .gitconfig to user home directory."

New-FileBackup $gitConfigFileName $gitConfigOutputFileName
((Get-Content -Path $gitConfigFileName -Raw).Replace('$(GitConfigCoreExcludesFileName)', $gitConfigCoreExcludesFileName).Replace('$(GitConfigUserEmail)', $gitConfigUserEmail).Replace('$(GitConfigUserName)', $gitConfigUserName)) `
    | Set-Content -path $gitConfigOutputFileName
