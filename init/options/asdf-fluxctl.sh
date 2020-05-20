#!/usr/bin/env bash

if is_macos || is_ubuntu; then
  asdf plugin add fluxctl
  asdf install fluxctl latest
  asdf global fluxctl "$(asdf latest fluxctl)"
fi
