#!/usr/bin/env bash

if is_macos; then
  brew cask install discord
fi

if is_ubuntu; then
  # sudo snap install discord
  # flatpak install -y flathub com.discordapp.Discord
  wget 'https://discordapp.com/api/download?platform=linux&format=deb' -O "$DOTFILES_INSTALLERS/discord.deb"
  sudo dpkg -i "$DOTFILES_INSTALLERS/discord.deb"
  sudo apt-get install -f -y
fi

if is_windows; then
  choco install -y discord
fi
