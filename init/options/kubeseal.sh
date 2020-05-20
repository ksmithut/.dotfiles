#!/usr/bin/env bash

if is_macos; then
  brew install kubeseal
fi

if is_ubuntu; then
  wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.12.3/kubeseal-linux-amd64 -O kubeseal
  sudo install -m 755 kubeseal /usr/local/bin/kubeseal
  rm kubeseal
fi
