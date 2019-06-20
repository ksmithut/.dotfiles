#!/usr/bin/env bash

if is_macos; then
  brew cask install kitematic
fi

if is_linux; then
  wget https://github.com/docker/kitematic/releases/download/v0.17.7/Kitematic-0.17.7-Ubuntu.zip -O kitematic.zip
  unzip kitematic.zip -d "$DOTFILES/caches/installers/kitematic.deb"
  sudo dpkg -i "$DOTFILES/caches/installers/kitematic.deb"
  sudo apt-get install -f -y
fi
