# make the required directories
mkdir ~/.npm

# install nvm https://github.com/creationix/nvm#manual-install
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/creationix/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
) && . "$NVM_DIR/nvm.sh"

# install latest version of node
nvm install node stable
nvm alias default node stable

# Adds yarn autocomplete
# https://github.com/dsifford/yarn-completion
# https://github.com/yarnpkg/yarn/issues/609
curl -o /usr/local/etc/bash_completion.d/yarn.completion https://raw.githubusercontent.com/dsifford/yarn-completion/master/yarn-completion.bash

yarn global add now
