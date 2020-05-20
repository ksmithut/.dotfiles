#!/usr/bin/env bash

if is_macos || is_ubuntu; then
  asdf plugin add kops
  asdf install kops latest
  asdf global kops "$(asdf latest kops)"
fi
