#!/usr/bin/env bash

if is_macos; then
  brew cask install chromium
fi

if is_linux; then
  sudo snap install chromium
fi
