#!/usr/bin/env zsh

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

alias run='node --run'
