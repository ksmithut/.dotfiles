#!/usr/bin/env bash

if is_macos; then
  brew install ykman
fi

if is_ubuntu; then
  sudo apt-add-repository ppa:yubico/stable
  sudo apt update -y
  sudo apt install -y yubikey-manager
fi
