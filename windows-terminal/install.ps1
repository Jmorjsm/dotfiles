Write-Output "`tCopying settings.json to Windows Terminal AppData folder..."
Copy-ItemWithBackup "settings.json" "$env:UserProfile\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
