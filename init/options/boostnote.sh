#!/usr/bin/env bash

if is_macos; then
  brew cask install boostnote
fi

if is_ubuntu; then
  wget https://github.com/BoostIO/boost-releases/releases/download/v0.13.0/boostnote_0.13.0_amd64.deb -O "$DOTFILES/caches/installers/boostnote.deb"
  sudo dpkg -i "$DOTFILES/caches/installers/boostnote.deb"
  sudo apt-get install -f -y
fi

if is_windows; then
  choco install -y boostnote
fi
