#!/usr/bin/env bash

sudo chown -R "$USER":"$USER" /usr/local/bin/

sudo apt-get update -y
sudo apt-get upgrade -y

if [[ ! $(command -v snap) ]]; then
  sudo apt-get install -y snapd
fi

if [[ ! $(command -v flatpak) ]]; then
  sudo apt install -y flatpak
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

sudo apt-get install -y \
  autojump \
  build-essential \
  curl \
  gnupg2 \
  gvfs-bin \
  jq \
  libgconf-2-4 \
  neofetch \
  python \
  ruby \
  tmux \
  trash-cli \
  tree \
  vim \
  wget \
  xclip \
  zsh

sudo snap install htop

sudo apt-get install -y \
  gnome-shell-extensions \
  gnome-tweak-tool

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

# install-gnome-extension 484 # workspace-grid
# install-gnome-extension 28 # gtile

# Remove dock
sudo apt-get remove gnome-shell-extension-ubuntu-dock -y
# flatpak gnome software
# sudo apt install -y gnome-software-plugin-flatpak
