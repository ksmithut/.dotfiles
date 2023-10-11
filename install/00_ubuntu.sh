#!/usr/bin/env bash
is-ubuntu || return

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
  jq \
  libgconf-2-4 \
  neofetch \
  python2 \
  python3 \
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
  gnome-tweaks
