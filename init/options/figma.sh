#!/usr/bin/env bash

if is_macos; then
  brew cask install figma
fi

if is_ubuntu; then
  # sudo snap install figma-linux
  wget 'https://github.com/ChugunovRoman/figma-linux/releases/download/v0.5.1/figma-linux_0.5.1_amd64.deb' -O "$DOTFILES/caches/installers/figma.deb"
  sudo dpkg -i "$DOTFILES/caches/installers/figma.deb"
  sudo apt-get install -f -y
fi

if is_windows; then
  choco install -y figma
fi
