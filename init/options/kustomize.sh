#!/usr/bin/env bash

if is_macos; then
  brew install kustomize
fi

if is_ubuntu; then
  curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
fi

if is_windows; then
  choco install -y kustomize
fi
