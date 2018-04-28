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
  xclip \
  gnome-tweak-tool \
  pass

if is_ubuntu_desktop; then
  # Remove dock
  sudo apt-get remove gnome-shell-extension-ubuntu-dock -y

  sudo snap install vscode --classic
  sudo snap install chromium
  sudo snap install insomnia
  sudo snap install docker
  sudo snap install slack --classic

  # Gnome extensions
  # Tiling window manager
  git clone https://github.com/gTile/gTile.git ~/.local/share/gnome-shell/extensions/gTile@vibou

  # docker-compose
  sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  # docker permissions
  sudo groupadd docker || true
  sudo gpasswd -a $USER docker
  sudo usermod -aG docker $USER
fi

# yarn
# https://yarnpkg.com/en/docs/install#linux-tab
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update -y && sudo apt-get install yarn -y

# pass otp
# https://github.com/tadfisher/pass-otp
git clone https://github.com/tadfisher/pass-otp "$DOTFILES/caches/installers/pass-otp"
builtin cd "$DOTFILES/caches/installers/pass-otp"
sudo make install
builtin cd -
