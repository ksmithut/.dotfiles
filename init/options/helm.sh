#!/usr/bin/env bash

if is_macos; then
  brew install helm
fi

if is_ubuntu; then
  curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
fi

if is_windows; then
  choco install -y kubernetes-helm
fi
