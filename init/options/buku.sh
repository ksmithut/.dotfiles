#!/usr/bin/env bash

if is_macos; then
  brew install buku
fi

if is_linux; then
  sudo apt-get install -y buku
fi
