#!/usr/bin/env bash

if is_macos || is_ubuntu; then
  asdf plugin add golang
  asdf install golang latest
  asdf global golang "$(asdf latest golang)"
fi
