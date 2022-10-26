#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh

brew install autoconf openssl@1.1 wxwidgets

export KERL_CONFIGURE_OPTIONS="--without-javac --with-ssl=$(brew --prefix openssl@1.1)"

asdf plugin add erlang
asdf install erlang latest
asdf global erlang "$(asdf latest erlang)"

asdf plugin add elixir
asdf install elixir latest
asdf global elixir "$(asdf latest elixir)"
