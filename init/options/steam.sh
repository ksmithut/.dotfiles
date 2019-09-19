#!/usr/bin/env bash

if is_macos; then
  brew cask install steam
fi

if is_ubuntu; then
  # flatpak install -y flathub com.valvesoftware.Steam
  wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb -O "$DOTFILES/caches/installers/steam.deb"
  sudo dpkg -i "$DOTFILES/caches/installers/steam.deb"
  sudo apt-get install -f -y
fi

if is_windows; then
  choco install -y steam
fi
