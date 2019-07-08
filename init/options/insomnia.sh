#!/usr/bin/env bash

if is_macos; then
  brew cask install insomnia
fi

if is_ubuntu; then
  # sudo snap install insomnia
  wget 'https://updates.insomnia.rest/downloads/ubuntu/latest' -O "$DOTFILES/caches/installers/insomnia.deb"
  sudo dpkg -i "$DOTFILES/caches/installers/insomnia.deb"
  sudo apt-get install -f -y
fi

if is_windows; then
  choco install -y insomnia-rest-api-client
fi
