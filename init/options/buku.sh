#!/usr/bin/env bash

if is_macos; then
  brew install buku
fi

if is_ubuntu; then
  sudo apt-get install -y buku
fi
