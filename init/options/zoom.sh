#!/usr/bin/env bash

if is_macos; then
  brew cask install zoomus
fi

if is_ubuntu; then
  wget https://zoom.us/client/latest/zoom_amd64.deb -O "$DOTFILES_INSTALLERS/zoom.deb"
  sudo dpkg -i "$DOTFILES_INSTALLERS/zoom.deb"
  sudo apt-get install -f -y
fi

if is_windows; then
  choco install -y zoom
fi
