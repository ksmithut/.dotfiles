#!/usr/bin/env bash

if is_macos; then
  brew install \
    coreutils automake autoconf openssl \
    libyaml readline libxslt libtool unixodbc \
    unzip curl
  brew install asdf
  . $HOME/.asdf/asdf.sh
fi

if is_ubuntu; then
  sudo apt install -y \
    automake autoconf libreadline-dev \
    libncurses-dev libssl-dev libyaml-dev \
    libxslt-dev libffi-dev libtool unixodbc-dev \
    unzip curl

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"
  cd -
  . $HOME/.asdf/asdf.sh
fi
