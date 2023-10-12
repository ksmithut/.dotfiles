#!/usr/bin/env bash
is-macos || is-linux || return

. "$(brew --prefix asdf)/libexec/asdf.sh"

asdf-latest () {
  asdf install "$1" latest
  asdf global "$1" latest
}

asdf-install () {
  asdf plugin add "$1"
  asdf-latest "$1"
}

# Shell things
asdf-install bats

# Golang
asdf-install golang

# Elixir
export KERL_CONFIGURE_OPTIONS="--without-javac"
asdf-install erlang
asdf-install elixir

# Node/JavaScript
asdf plugin add nodejs
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf-latest nodejs
echo 'legacy_version_file = yes' >> ~/.asdfrc
asdf-install yarn
asdf-install deno
asdf-install bun
