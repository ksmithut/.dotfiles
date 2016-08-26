# make the required directories
mkdir ~/.npm

export NVM_DIR=~/.nvm
# install nvm https://github.com/creationix/nvm#install-script
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/creationix/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
) && . "$NVM_DIR/nvm.sh"
# source nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# install latest version of node
nvm install node stable
nvm alias default node stable
