#!/usr/bin/env sh

. $HOME/.asdf/asdf.sh

asdf plugin add erlang
asdf install erlang latest
asdf global erlang "$(asdf latest erlang)"

asdf plugin add elixir
asdf install elixir latest
asdf global elixir "$(asdf latest elixir)"
