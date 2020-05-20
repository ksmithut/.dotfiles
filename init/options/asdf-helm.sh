#!/usr/bin/env bash

if is_macos || is_ubuntu; then
  asdf plugin add helm
  asdf install helm latest
  asdf global helm "$(asdf latest helm)"
fi
