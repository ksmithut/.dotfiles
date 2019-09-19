#!/usr/bin/env bash

if is_macos; then
  brew cask install chromium
fi

if is_ubuntu; then
  # sudo snap install chromium
  sudo apt-get install -y chromium-browser
fi

if is_windows; then
  choco install -y chromium
fi
