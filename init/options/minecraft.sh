#!/usr/bin/env bash

if is_macos; then
  brew cask install minecraft
fi

if is_windows; then
  choco install -y minecraft
fi
