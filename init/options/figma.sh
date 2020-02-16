#!/usr/bin/env bash

if is_macos; then
  brew cask install figma
fi

if is_ubuntu; then
  # sudo snap install figma-linux
  sudo add-apt-repository -y ppa:chrdevs/figma
  sudo apt-get update -y
  sudo apt-key adv --recv-key --keyserver keyserver.ubuntu.com 70F3445E637983CC
  sudo apt install figma-linux -y
  sudo apt-get install -f -y
fi

if is_windows; then
  choco install -y figma
fi
