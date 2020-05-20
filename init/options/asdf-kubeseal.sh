#!/usr/bin/env bash

if is_macos || is_ubuntu; then
  asdf plugin add kubeseal
  asdf install kubeseal latest
  asdf global kubeseal "$(asdf latest kubeseal)"
fi
