#!/usr/bin/env bash

if is_macos || is_ubuntu; then
  asdf plugin add erlang
  asdf install erlang latest
  asdf global erlang "$(asdf latest erlang)"

  asdf plugin add elixir
  asdf install elixir latest
  asdf global elixir "$(asdf latest elixir)"
fi
