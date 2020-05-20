#!/usr/bin/env bash

if is_macos || is_ubuntu; then
  asdf plugin add eksctl
  asdf install eksctl latest
  asdf global eksctl "$(asdf latest eksctl)"
fi
