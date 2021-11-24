#!/usr/bin/env bash

PATH="$(yarn global bin):$PATH"
export PATH

function node-setup() {
  yarn create gameplan https://github.com/ksmithut/gameplan-node "$1" --prompt
}

function react-setup() {
  yarn create gameplan https://github.com/ksmithut/gameplan-react "$1" --prompt
}

function lint-setup() {
  yarn add -D eslint-config-standard eslint-config-standard-jsx @ksmithut/prettier-standard
  npm set-script 'format' 'prettier-standard --lint'
  npm set-script 'lint' 'prettier-standard --check --lint'
  echo  '{\n  "extends":["standard", "standard-jsx"]\n}' > .eslintrc.json
}

function precommit-setup() {
  yarn add -D husky lint-staged
  npm set-script 'prepare' 'husky install || true'
  yarn prepare
  echo "export default {\n  '**/*': 'prettier-standard --lint',\n  '**/*.{js,json}': () => 'tsc'\n}" > .lintstagedrc.js
  yarn husky add .husky/pre-commit 'npx lint-staged'
}

alias npm-upgrade-interactive='npx -y npm-check-updates@latest --interactive'

# Upgrade nvm
function nvm-upgrade() {
  cd "$NVM_DIR" || exit
  git fetch --tags origin
  git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" "$(git rev-list --tags --max-count=1)")"
  cd - > /dev/null || exit
  # shellcheck disable=SC1090
  \. "$NVM_DIR/nvm.sh"
}
