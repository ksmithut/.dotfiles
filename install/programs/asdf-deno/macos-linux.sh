#!/usr/bin/env sh

. $HOME/.asdf/asdf.sh

asdf plugin add deno
asdf install deno latest
asdf global deno "$(asdf latest deno)"
