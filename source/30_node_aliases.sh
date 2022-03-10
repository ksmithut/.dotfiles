#!/usr/bin/env zsh

PATH="$(yarn global bin):$PATH"
export PATH

function node-setup() {
  yarn create gameplan https://github.com/ksmithut/gameplan-node "$1" --prompt
}

function react-setup() {
  yarn create gameplan https://github.com/ksmithut/gameplan-react "$1" --prompt
}

alias lint-setup='template lint .'
alias precommit-setup='template precommit .'

alias npm-upgrade-interactive='npx -y npm-check-updates@latest --interactive'

# Upgrade nvm
function nvm-upgrade() {
  builtin cd "$NVM_DIR" || exit
  git fetch --tags origin
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  builtin cd - > /dev/null || exit
  # shellcheck disable=SC1090
  \. "$NVM_DIR/nvm.sh"
}

function template() {
  if [ "$1" = "" ]; then
    ls "${DOTFILES}/.templates"
    return 0
  fi
  if [ "$2" = "" ]; then
    echo 'You must pass in two arguments'
    echo 'template <template> <name>'
    return 1
  fi
  local template_path="${DOTFILES}/.templates/$1"
  if [ -d "${template_path}" ]; then
    cp -R "${template_path}/" "$2"
    cd "$2"
    local init_script_path="./.template.sh"
    if [ -f "${init_script_path}" ]; then
      sh "${init_script_path}"
      rm "${init_script_path}"
    fi
  else
    echo "No template with name '${1}' found"
    return 1
  fi
}
