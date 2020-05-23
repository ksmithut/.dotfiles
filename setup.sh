#!/usr/bin/env bash

os="linux"
if [[ "$OSTYPE" =~ ^darwin ]]; then
  os="macos"
fi

mkdir -p ~/.local/bin
wget "https://github.com/ksmithut/doted/releases/download/0.0.0/doted-${os}" -O ~/.local/bin/doted

doted setup

unset os
