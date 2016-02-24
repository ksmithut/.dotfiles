#!/usr/bin/env bash

# install nvm https://github.com/creationix/nvm#install-script
_latest=`echo $(curl https://api.github.com/repos/creationix/nvm/releases/latest --silent) | grep -o '"tag_name": .*[^\\]"' | cut -d '"' -f 4`
curl -o- https://raw.githubusercontent.com/creationix/nvm/$_latest/install.sh | bash
unset _latest

# make the required directories
mkdir ~/.npm

export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# install latest version of node
nvm install node stable
nvm alias default node stable

# make it so we don't have to sudo npm
sudo chown -R `whoami` ~/.npm

echo "Add npm user..."

# add your npm user
npm adduser
