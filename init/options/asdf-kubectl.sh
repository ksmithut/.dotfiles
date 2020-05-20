#!/usr/bin/env bash

if is_macos || is_ubuntu; then
  asdf plugin add kubectl
  asdf install kubectl latest
  asdf global kubectl "$(asdf latest kubectl)"
fi
