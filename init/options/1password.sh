#!/usr/bin/env bash

if is_macos; then
  brew cask install 1password
else
  echo 'Use the 1password extension in your browser'
fi
