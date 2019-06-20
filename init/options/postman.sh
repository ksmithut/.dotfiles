#!/usr/bin/env bash

if is_macos; then
  brew cask install postman
fi

if is_linux; then
  sudo snap install postman
  # flatpak install -y com.getpostman.Postman
fi
