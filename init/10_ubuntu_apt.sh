#!/usr/bin/env bash
# Ubuntu/Pop!_OS-only stuff. Abort if macOS.
is_ubuntu || return 1

# Note that this is pretty fragile. This is basically going through and parsing
# a value out of an attribute on an html page and going through the versions and
# selecting the latest version. If there were a better cli for installing
# extensions, I would rather use that, but this will do for now.
function install-gnome-extension() {
  local major_version
  local minor_version
  local patch_version
  local version
  local extension_info
  local download_path
  local uuid
  major_version="$(grep '<platform>' /usr/share/gnome/gnome-version.xml | sed -n 's/.*>\([0-9]*\)<.*/\1/p')"
  minor_version="$(grep '<minor>' /usr/share/gnome/gnome-version.xml | sed -n 's/.*>\([0-9]*\)<.*/\1/p')"
  patch_version="$(grep '<micro>' /usr/share/gnome/gnome-version.xml | sed -n 's/.*>\([0-9]*\)<.*/\1/p')"
  version="$major_version.$minor_version.$patch_version"
  extension_info="$(curl -s "https://extensions.gnome.org/extension-info/?pk=$1&shell_version=$version" | jq 'del(.description)')"
  download_path="$(echo "$extension_info" | jq -r '.download_url')"
  uuid="$(echo "$extension_info" | jq -r '.uuid')"
  wget "https://extensions.gnome.org$download_path" -O "$uuid.zip"
  rm -rf "$HOME/.local/share/gnome-shell/extensions/$uuid"
  mkdir -p "$HOME/.local/share/gnome-shell/extensions"
  unzip "$uuid.zip" -d "$HOME/.local/share/gnome-shell/extensions/$uuid"
  rm "$uuid.zip"
}

sudo add-apt-repository -y ppa:alexlarsson/flatpak
sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install -y \
  autojump \
  build-essential \
  buku \
  curl \
  flatpak \
  gnome-shell-extensions \
  gnome-tweak-tool \
  gvfs-bin \
  jq \
  libgconf-2-4 \
  neofetch \
  oathtool \
  python \
  ruby \
  snapd \
  tmux \
  trash-cli \
  tree \
  vim \
  wget \
  xclip \
  zsh

# sudo apt-get purge -y \
#   firefox

# Docker
# Remove prior versions
sudo apt-get remove docker docker-engine docker.io containerd runc
# install docker
curl -fsSL get.docker.com -o get-docker.sh
chmod a+x get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh
sudo usermod -aG docker "$USER"

# install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-"$(uname -s)"-"$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

if is_ubuntu_desktop || is_pop_desktop; then
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # Gnome extensions
  install-gnome-extension 484 # workspace-grid
  install-gnome-extension 28 # gtile

  # Remove dock
  sudo apt-get remove gnome-shell-extension-ubuntu-dock -y
  # flatpak gnome software
  sudo apt install -y gnome-software-plugin-flatpak

  flatpak install -y com.slack.Slack
  flatpak install -y com.visualstudio.code
  flatpak install -y com.discordapp.Discord
  flatpak install -y com.getpostman.Postman
  flatpak install -y org.videolan.VLC
  flatpak install -y com.valvesoftware.Steam

  sudo snap install chromium
  sudo snap install htop
  sudo snap install insomnia

  # Keybase
  wget https://prerelease.keybase.io/keybase_amd64.deb -O "$DOTFILES/caches/installers/keybase.deb"
  sudo dpkg -i "$DOTFILES/caches/installers/keybase.deb"
  sudo apt-get install -f -y

  # Boostnote
  wget https://github.com/BoostIO/boost-releases/releases/download/v0.11.15/boostnote_0.11.15_amd64.deb -O "$DOTFILES/caches/installers/boostnote.deb"
  sudo dpkg -i "$DOTFILES/caches/installers/boostnote.deb"
  sudo apt-get install -f -y
fi

# yarn
# https://yarnpkg.com/en/docs/install#debian-stable
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update -y
sudo apt-get install yarn -y

# Erlang/Elixir
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -O "$DOTFILES/caches/installers/erlang.deb"
sudo dpkg -i "$DOTFILES/caches/installers/erlang.deb"
sudo apt-get update
sudo apt-get install -y esl-erlang
sudo apt-get install -y elixir

# SDKMan!
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh" 
