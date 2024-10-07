#!/usr/bin/env bash
is-macos || is-linux || return

# Golang
mise use --global go@latest

# Elixir
export KERL_CONFIGURE_OPTIONS="--without-javac"
mise use --global erlang@latest
mise use --global elixir@latest

# Node/JavaScript
muse use --global node@latest
muse use --global deno@latest
muse use --global bun@latest

# Terraform
muse use --global terraform@latest
