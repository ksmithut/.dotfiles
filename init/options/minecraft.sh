#!/usr/bin/env bash

if is_macos; then
  brew cask install minecraft
fi

if is_ubuntu; then
  wget 'https://launcher.mojang.com/download/Minecraft.deb' -O "$DOTFILES_INSTALLERS/minecraft.deb"
  sudo dpkg -i "$DOTFILES_INSTALLERS/minecraft.deb"
  sudo apt-get install -f -y
fi

if is_windows; then
  choco install -y minecraft
fi
