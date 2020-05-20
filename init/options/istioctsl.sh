#!/usr/bin/env bash

if is_macos; then
  brew install istioctl
fi

if is_ubuntu; then
  curl -L https://istio.io/downloadIstio | sh -
fi
