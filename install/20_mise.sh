#!/usr/bin/env bash
is-macos || is-linux || return

# Golang
mise use --global go@latest

# Elixir
export KERL_CONFIGURE_OPTIONS="--without-javac"
mise use --global erlang@latest
mise use --global elixir@latest

# Node/JavaScript
mise use --global node@latest
mise use --global deno@latest
mise use --global bun@latest

# Terraform
mise use --global terraform@latest
