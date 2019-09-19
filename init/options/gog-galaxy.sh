#!/usr/bin/env bash

if is_macos; then
  brew cask install gog-galaxy
fi

if is_windows; then
  choco install -y goggalaxy
fi
