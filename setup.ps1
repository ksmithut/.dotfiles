. "$PSScriptRoot\install\pre_windows.ps1"

$env:DOTFILES = $PSScriptRoot
bash "$PSScriptRoot\setup.sh"
