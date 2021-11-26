#!/usr/bin/env bash

brew install yarn

# make the required directories
mkdir ~/.npm

# https://github.com/nvm-sh/nvm#manual-install
# shellcheck disable=SC1090
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  builtin cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

# install latest version of node
nvm install node
nvm alias default node
