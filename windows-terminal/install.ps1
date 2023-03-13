Write-Output "`tCopying settings.json to Windows Terminal AppData folder..."

$previewSettingsPath = "$env:UserProfile\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
if(test-path $previewSettingsPath)
{
    Copy-ItemWithBackup "settings.json" $previewSettingsPath
}

$mainSettingsPath = "$env:UserProfile\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
if(test-path $mainSettingsPath)
{
    Copy-ItemWithBackup "settings.json" $mainSettingsPath
}
