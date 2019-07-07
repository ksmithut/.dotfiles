#!/usr/bin/env bash

if is_macos; then
  brew cask install steam
fi

if is_ubuntu; then
  flatpak install -y flathub com.valvesoftware.Steam
fi

if is_windows; then
  choco install -y steam
fi
