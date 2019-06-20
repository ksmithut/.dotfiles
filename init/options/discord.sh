#!/usr/bin/env bash

if is_macos; then
  brew cask install discord
fi

if is_ubuntu; then
  sudo snap install discord
  # flatpak install -y flathub com.discordapp.Discord
fi
