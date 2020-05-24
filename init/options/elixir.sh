#!/usr/bin/env bash

if is_macos; then
  brew install elixir
fi

if is_ubuntu; then
  wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb -O "$DOTFILES_INSTALLERS/erlang.deb"
  sudo dpkg -i "$DOTFILES_INSTALLERS/erlang.deb"
  sudo apt-get update
  sudo apt-get install -y esl-erlang
  sudo apt-get install -y elixir
fi

if is_windows; then
  choco install -y elixir
fi
