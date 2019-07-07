#!/usr/bin/env bash

if is_macos; then
  brew cask install insomnia
fi

if is_ubuntu; then
  sudo snap install insomnia
fi

if is_windows; then
  choco install -y insomnia-rest-api-client
fi
