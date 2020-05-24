#!/usr/bin/env bash

if is_macos; then
  brew cask install boostnote
fi

if is_ubuntu; then
  wget https://github.com/BoostIO/boost-releases/releases/download/v0.15.3/boostnote_0.15.3_amd64.deb -O "$DOTFILES_INSTALLERS/boostnote.deb"
  sudo dpkg -i "$DOTFILES_INSTALLERS/boostnote.deb"
  sudo apt-get install -f -y
fi

if is_windows; then
  choco install -y boostnote
fi
