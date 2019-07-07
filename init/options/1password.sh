#!/usr/bin/env bash

if is_macos; then
  brew cask install 1password
fi

if is_windows; then
  # Waiting for this issue: https://github.com/chocolatey-community/chocolatey-coreteampackages/issues/1186
  # choco install -y 1password
fi
