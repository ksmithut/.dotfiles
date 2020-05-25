. "$PSScriptRoot\install\pre_windows.ps1"

$env:Path = "C:\Program Files\Git\bin;$env:Path"
$env:DOTFILES = $PSScriptRoot
bash $PSScriptRoot\setup.sh"
