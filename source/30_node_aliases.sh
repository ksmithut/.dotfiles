#!/usr/bin/env bash

function node-setup() {
  yarn create gameplan https://github.com/ksmithut/gameplan-node "$1" --prompt
}

function react-setup() {
  yarn create gameplan https://github.com/ksmithut/gameplan-react "$1" --prompt
}

function eslint-setup() {
  yarn add -D \
    standard \
    prettier-eslint-cli
  cat package.json \
    | jq '.scripts.format = "prettier-eslint ''src/**/*.js'' --write"' \
    | jq '.scripts.lint = "eslint ''src/**/*.js'' && prettier-eslint ''src/**/*.js'' --list-different"' \
    | tee package.json
  echo '{}' | jq '.extends = ["standard"]' | tee .eslintrc
}

# Upgrade nvm
function nvm-upgrade() {
  cd "$NVM_DIR" || exit
  git fetch --tags origin
  git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" "$(git rev-list --tags --max-count=1)")"
  cd - > /dev/null || exit
  # shellcheck disable=SC1090
  \. "$NVM_DIR/nvm.sh"
}
