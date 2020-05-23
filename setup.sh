#!/usr/bin/env bash

os="linux"
if [[ "$OSTYPE" =~ ^darwin ]]; then
  os="macos"
fi

version="0.0.0"

mkdir -p ~/.local/bin
wget "https://github.com/ksmithut/doted/releases/download/${version}/doted-${os}" -O ~/.local/bin/doted
chmod a+x ~/.local/bin/doted
~/.local/bin/doted setup

unset os
