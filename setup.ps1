$DOTFILES = $PSScriptRoot
$DOTFILES_OPTIONS_FILE = "$DOTFILES\\options.template.sh"

function dotfiles_init () {
  echo 'Initializing system'

  $selected_environments = @()
  $raw_environments = (sh "$DOTFILES_OPTIONS_FILE" "_") | Out-String
  $environments = ($raw_environments -split '\r?\n').Trim()
  echo $environments
}

dotfiles_init
