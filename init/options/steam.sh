#!/usr/bin/env bash

if is_macos; then
  brew cask install steam
fi

if is_linux; then
  flatpak install -y com.valvesoftware.Steam
fi
