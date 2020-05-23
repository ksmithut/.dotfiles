#!/usr/bin/env sh

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update -y
sudo apt-get install -y --no-install-recommends yarn

# make the required directories
mkdir ~/.npm

# install nvm https://github.com/creationix/nvm#manual-install
# shellcheck disable=SC1090
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/creationix/nvm.git "$NVM_DIR"
  builtin cd "$NVM_DIR"
  git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" "$(git rev-list --tags --max-count=1)")"
) && \. "$NVM_DIR/nvm.sh"

# install latest version of node
nvm install 10
nvm install 12
nvm install 14
nvm install node
nvm alias default node
