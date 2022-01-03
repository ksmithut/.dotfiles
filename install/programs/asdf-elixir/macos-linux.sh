#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh

sudo apt-get install libssl-dev automake autoconf libncurses5-dev -y

asdf plugin add erlang
asdf install erlang latest
asdf global erlang "$(asdf latest erlang)"

asdf plugin add elixir
asdf install elixir latest
asdf global elixir "$(asdf latest elixir)"
