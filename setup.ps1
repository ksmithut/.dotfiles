. "$PSScriptRoot\install\pre_windows.ps1"

$env:DOTFILES = $PSScriptRoot
"C:\Program Files\Git\bin\bash.exe" "$PSScriptRoot\setup.sh"
