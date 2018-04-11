# Ubuntu-only stuff. Abort if macOS.
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
  vim \
  xclip

# Create installers foler
mkdir -p "$DOTFILES/caches/installers/"

if is_ubuntu_desktop; then
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

  # Slack
  wget -O "$DOTFILES/caches/installers/slack.deb" https://downloads.slack-edge.com/linux_releases/slack-desktop-2.9.0-amd64.deb
  sudo dpkg -i "$DOTFILES/caches/installers/slack.deb"
  sudo apt-get install -fy

  # Gnome extensions
  # Tiling window manager
  git clone https://github.com/vibou/vibou.gTile.git ~/.local/share/gnome-shell/extensions/gTile@vibou
fi

# yarn
# https://yarnpkg.com/en/docs/install#linux-tab
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update -y && sudo apt-get install yarn -y

# # docker
# # https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce
# sudo apt-get install -y \
#   apt-transport-https \
#   ca-certificates \
#   curl \
#   software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository \
#   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) \
#   stable"
# sudo apt-get update -y
# sudo apt-get install docker-ce -y
# # Add current user to docker group
# sudo groupadd docker
# sudo gpasswd -a $USER docker
# sudo usermod -aG docker $USER
# newgrp docker
# # docker-compose
# sudo curl -L https://github.com/docker/compose/releases/download/latest/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose

# pass and pass otp
# https://github.com/tadfisher/pass-otp
wget -O "$DOTFILES/caches/installers/pass.tar.xz" https://git.zx2c4.com/password-store/snapshot/password-store-1.7.1.tar.xz
tar xf "$DOTFILES/caches/installers/pass.tar.xz" "$DOTFILES/caches/installers/password-store-1.7.1"
builtin cd "$DOTFILES/caches/installers/password-store-1.7.1"
sudo make install
builtin cd -

git clone https://github.com/tadfisher/pass-otp "$DOTFILES/caches/installers/pass-otp"
builtin cd "$DOTFILES/caches/installers/pass-otp"
sudo make install
builtin cd -
