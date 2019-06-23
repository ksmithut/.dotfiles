#!/usr/bin/env bash

if is_macos; then
  brew cask install spotify
fi

if is_ubuntu; then
  sudo snap install spotify
  # flatpak install flathub com.spotify.Client
fi