#!/usr/bin/env bash

if is_macos; then
  brew cask install figma
fi

if is_ubuntu; then
  sudo snap install figma-linux
fi

if is_windows; then
  choco install -y figma
fi
