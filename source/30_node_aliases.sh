#!/usr/bin/env zsh

PATH="$(yarn global bin):$PATH"
export PATH

alias npm-upgrade-interactive='npx -y npm-check-updates@latest --interactive'
alias yarn="corepack yarn"
alias yarnpkg="corepack yarnpkg"
alias pnpm="corepack pnpm"
alias pnpx="corepack pnpx"
alias npm="corepack npm"
alias npx="corepack npx"

# Upgrade nvm
function nvm-upgrade() {
  builtin cd "$NVM_DIR" || exit
  git fetch --tags origin
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  builtin cd - > /dev/null || exit
  # shellcheck disable=SC1090
  \. "$NVM_DIR/nvm.sh"
}
