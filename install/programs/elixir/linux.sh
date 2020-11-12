#!/usr/bin/env bash

# UPDATE_VERSION - https://elixir-lang.org/install.html

wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb -O "$DOTFILES_INSTALLERS/erlang.deb"
sudo dpkg -i "$DOTFILES_INSTALLERS/erlang.deb"
sudo apt-get update
sudo apt-get install -y esl-erlang
sudo apt-get install -y elixir
