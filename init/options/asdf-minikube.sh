#!/usr/bin/env bash

if is_macos || is_ubuntu; then
  asdf plugin add minikube
  asdf install minikube latest
  asdf global minikube "$(asdf latest minikube)"
fi
