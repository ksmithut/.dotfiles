#!/usr/bin/env bash

if is_macos; then
  brew cask install discord
fi

if is_linux; then
  sudo snap install discord
  # flatpak install -y com.discordapp.Discord
fi
