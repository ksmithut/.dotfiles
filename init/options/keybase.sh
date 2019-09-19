#!/usr/bin/env bash

if is_macos; then
  brew cask install keybase
fi

if is_ubuntu; then
  # There is a snap for it, but it needs to be installed with the edge flag
  wget https://prerelease.keybase.io/keybase_amd64.deb -O "$DOTFILES/caches/installers/keybase.deb"
  sudo dpkg -i "$DOTFILES/caches/installers/keybase.deb"
  sudo apt-get install -f -y
fi

if is_windows; then
  choco install -y keybase
fi
