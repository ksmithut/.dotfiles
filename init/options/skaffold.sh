#!/usr/bin/env bash

if is_macos; then
  brew install skaffold
fi

if is_ubuntu; then
  curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
  chmod +x skaffold
  sudo mv skaffold /usr/local/bin
fi

if is_windows; then
  choco install -y skaffold
fi
