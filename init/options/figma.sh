#!/usr/bin/env bash

if is_macos; then
  brew cask install figma
fi

if is_ubuntu; then
  # this is the unofficial way to install. Let's maybe wait for something more
  # official
  # sudo snap install figma-linux
fi
