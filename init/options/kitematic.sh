#!/usr/bin/env bash

if is_macos; then
  brew cask install kitematic
fi

if is_ubuntu; then
  wget https://github.com/docker/kitematic/releases/download/v0.17.11/Kitematic-0.17.11-Ubuntu.zip -O kitematic.zip
  unzip kitematic.zip -d "$DOTFILES_INSTALLERS/kitematic"
  rm kitematic.zip
  sudo dpkg -i "$DOTFILES_INSTALLERS/kitematic/Kitematic-0.17.11_amd64.deb"
  sudo apt-get install -f -y
fi

if is_windows; then
  choco install -y docker-kitematic
fi
