#!/usr/bin/env bash

if is_macos; then
  brew cask install league-of-legends
fi

if is_windows; then
  choco install -y leagueoflegends
fi
