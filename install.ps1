$installScripts = $(
    "powershell", 
    "git", 
    "windows-terminal"
)

$repoRoot = $PSScriptRoot

$backupsDirectory = Join-Path $repoRoot "backups"
New-Item -ItemType Directory -Force -Path $backupsDirectory

function New-FileBackup($fromPath, $toPath) {
    $fromFullPath = Resolve-Path $fromPath

    # Get the path of the source file relative to the repo root
    $tmpWorkingDir = Get-Location
    Set-location $repoRoot
    $fromRelativePath = Resolve-Path -relative $fromFullPath
    Set-Location $tmpWorkingDir

    # Get the relative path of the dir so we know the file structure to use for the backup path
    $fromRelativeDirPath = Split-Path $fromRelativePath
    $backupDirPath = Join-Path $backupsDirectory $fromRelativeDirPath
    
    # Ensure the backup file path exists
    New-Item -ItemType Directory -Force -Path $backupDirPath

    # Combine the file name and the backup file dir path
    $backupFileName = Join-Path $backupDirPath $fromPath
    
    # Copy the target file to the backup dir
    Copy-Item $toPath $backupFileName
}

function Copy-ItemWithBackup($fromPath, $toPath) {
    New-FileBackup $fromPath $toPath
    Copy-Item $fromPath $toPath
}

for ($scriptIndex = 0; $scriptIndex -lt $installScripts.Count; $scriptIndex++) {
    $currentScriptName = $installScripts[$scriptIndex]

    $currentScriptDirName = Join-Path $repoRoot $currentScriptName

    Push-Location $currentScriptDirName
    $scriptFileName = "$currentScriptDirName\install.ps1"
    
    Write-Output "Installing script $($scriptIndex + 1) of $($installScripts.Count) - $currentScriptName"
    . $scriptFileName

    Pop-Location
}
