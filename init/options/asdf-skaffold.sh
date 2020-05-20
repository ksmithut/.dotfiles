#!/usr/bin/env bash

if is_macos || is_ubuntu; then
  asdf plugin add skaffold
  asdf install skaffold latest
  asdf global skaffold "$(asdf latest skaffold)"
fi
