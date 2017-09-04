# Ubuntu-only stuff. Abort if not OSX.
is_ubuntu || return 1

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install -y \
  curl \
  wget \
  build-essential \
  jq \
  tree \
  oathtool \
  vim

# Create installers foler
mkdir -p "$DOTFILES/caches/installers/"

# Remove LibreOffice
sudo apt-get remove --purge libreoffice* -y
sudo apt-get clean -y
sudo apt-get autoremove -y

# Visual Studio Code
# https://code.visualstudio.com/docs/setup/linux
wget -O "$DOTFILES/caches/installers/vscode.deb" https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable
sudo dpkg -i "$DOTFILES/caches/installers/vscode.deb"
sudo apt-get install -fy

# Chrome
wget -O "$DOTFILES/caches/installers/chrome.deb" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i "$DOTFILES/caches/installers/chrome.deb"
sudo apt-get install -fy

# yarn
# https://yarnpkg.com/en/docs/install#linux-tab
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update -y && sudo apt-get install yarn -y

# docker
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce
# https://download.docker.com/linux/ubuntu/dists/zesty/pool/stable/amd64/
wget -O "$DOTFILES/caches/installers/docker.deb" "https://download.docker.com/linux/ubuntu/dists/$(lsb_release -cs)/pool/stable/amd64/docker-ce_17.06.0~ce-0~ubuntu_amd64.deb"
sudo dpkg -i "$DOTFILES/caches/installers/docker.deb"
sudo apt-get install -fy
# Add current user to docker group
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
# docker-compose
curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Slack
wget -O "$DOTFILES/caches/installers/slack.deb" https://downloads.slack-edge.com/linux_releases/slack-desktop-2.6.3-amd64.deb
sudo dpkg -i "$DOTFILES/caches/installers/slack.deb"
sudo apt-get install -fy

# pass and pass otp
# https://github.com/tadfisher/pass-otp
wget -O "$DOTFILES/caches/installers/pass.tar.xz" https://git.zx2c4.com/password-store/snapshot/password-store-1.7.1.tar.xz
tar xf "$DOTFILES/caches/installers/pass.tar.xz"
builtin cd "$DOTFILES/caches/installers/password-store-1.7.1"
sudo make install
builtin cd -

git clone https://github.com/tadfisher/pass-otp "$DOTFILES/caches/installers/pass-otp"
builtin cd "$DOTFILES/caches/installers/pass-otp"
sudo make install
builtin cd -
