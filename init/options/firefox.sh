#!/usr/bin/env bash

if is_macos; then
  brew cask install firefox
fi

if is_ubuntu; then
  # for now leave the installed firefox alone
  # sudo apt-get purge -y firefox
  # sudo snap install firefox
fi
