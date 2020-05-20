#!/usr/bin/env bash

if is_macos; then
  brew tap weaveworks/tap
  brew install weaveworks/tap/eksctl
fi

if is_ubuntu; then
  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
  sudo mv /tmp/eksctl /usr/local/bin
fi
