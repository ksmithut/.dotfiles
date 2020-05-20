#!/usr/bin/env bash

if is_macos; then
  brew install awscli
fi

if is_ubuntu; then
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  rm -rf ./aws awscliv2.zip
fi
