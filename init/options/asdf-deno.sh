#!/usr/bin/env bash

if is_macos || is_ubuntu; then
  asdf plugin add deno
  asdf install deno latest
  asdf global deno "$(asdf latest deno)"
fi
