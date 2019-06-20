#!/usr/bin/env bash

if is_macos; then
  brew cask install postman
fi

if is_ubuntu; then
  sudo snap install postman
  # flatpak install -y flathub com.getpostman.Postman
fi
