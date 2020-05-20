#!/usr/bin/env bash

if is_macos || is_ubuntu; then
  asdf plugin add kustomize
  asdf install kustomize latest
  asdf global kustomize "$(asdf latest kustomize)"
fi
