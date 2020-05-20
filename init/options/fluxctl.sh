#!/usr/bin/env bash

if is_macos; then
  brew install fluxctl
fi

if is_ubuntu; then
  sudo snap install fluxctl
fi
