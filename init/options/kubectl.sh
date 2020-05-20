#!/usr/bin/env bash

if is_macos; then
  brew install kubernetes-cli
fi

if is_ubuntu; then
  sudo apt-get update && sudo apt-get install -y apt-transport-https
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
  sudo apt-get update
  sudo apt-get install -y kubectl
fi

if is_windows; then
  choco install -y kubernetes-cli
fi
