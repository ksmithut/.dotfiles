#!/usr/bin/env bash

if is_macos; then
  brew cask install kitematic
fi

if is_ubuntu; then
  wget https://github.com/docker/kitematic/releases/download/v0.17.9/Kitematic-0.17.9-Ubuntu.zip -O kitematic.zip
  unzip kitematic.zip -d "$DOTFILES/caches/installers/kitematic"
  rm kitematic.zip
  sudo dpkg -i "$DOTFILES/caches/installers/kitematic/Kitematic-0.17.9_amd64.deb"
  sudo apt-get install -f -y
fi

if is_windows; then
  choco install -y docker-kitematic
fi
