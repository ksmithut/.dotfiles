#!/usr/bin/env bash

if is_macos; then
  brew cask install steam
fi

if is_ubuntu; then
  flatpak install -y com.valvesoftware.Steam
fi
