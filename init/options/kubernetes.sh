#!/usr/bin/env bash

if is_macos; then
  brew install \
    kubernetes-cli \
    kubernetes-helm \
    kubeseal \
    kustomize \
    skaffold
  brew cask install \
    minikube \
    virtualbox
fi

# I still haven't figured out all of the kinks involved with installing the
# kubernetes tools on linux
