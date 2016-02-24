# make the required directories
mkdir ~/.npm

export NVM_DIR=~/.nvm
# install nvm https://github.com/creationix/nvm#install-script
git clone https://github.com/creationix/nvm.git $NVM_DIR && cd $NVM_DIR && git checkout `git describe --abbrev=0 --tags` && cd
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# install latest version of node
nvm install node stable
nvm alias default node stable

echo "Add npm user..."

# add your npm user
npm adduser
