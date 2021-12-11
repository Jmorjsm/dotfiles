[CmdletBinding()]
param (
    # The input path to source .ahk files to move to the startup directory
    [Parameter()]
    [string]
    $inputPath,
    
    # If true, all files in the provided path will be copied
    [Parameter(AttributeValues)]
    [switch]
    $All
    
)

$inputItem = Get-Item $inputPath
if ($inputItem -is [System.IO.DirectoryInfo])
{

    for ($i = 0; $i -lt $inputFiles.Count; $i++) {
        
    }
}

Copy-ItemWithBackup "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Start-up"