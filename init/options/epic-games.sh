#!/usr/bin/env bash

if is_macos; then
  brew cask install epic-games
fi

if is_windows; then
  choco install -y epicgameslauncher
fi
