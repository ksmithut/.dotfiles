. "$PSScriptRoot\init\00_pre_windows.ps1"

$env:DOTFILES = $PSScriptRoot
sh "$PSScriptRoot\setup.sh"
