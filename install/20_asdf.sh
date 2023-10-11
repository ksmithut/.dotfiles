#!/usr/bin/env bash
set -e
is-macos || is-linux || return

. "$HOME/.asdf/asdf.sh"

asdf-latest () {
  asdf install "$1" latest
  asdf global "$1" "$(asdf latest "$1")"
}

asdf-install () {
  asdf plugin add "$1"
  asdf-latest "$1"
}

asdf-install deno
asdf-install erlang
asdf-install elixir
asdf-install golang
asdf-install lazydocker
asdf-install mongo-tools

asdf plugin add nodejs
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf-latest nodejs
echo 'legacy_version_file = yes' >> ~/.asdfrc

asdf-install yarn
