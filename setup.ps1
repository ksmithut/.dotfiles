$env:DOTFILES = $PSScriptRoot
$env:FROM_POWERSHELL = 'true'
sh "$PSScriptRoot\test.sh"
