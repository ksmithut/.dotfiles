#!/usr/bin/env bash

if is_macos; then
  brew cask install jeromelebel-mongohub
fi

if is_ubuntu; then
  sudo snap install robo3t-snap
fi

if is_windows; then
  choco install -y studio3t
fi
