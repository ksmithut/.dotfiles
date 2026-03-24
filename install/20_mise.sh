#!/usr/bin/env bash
is-macos || is-linux || return

# Elixir
export KERL_CONFIGURE_OPTIONS="--without-javac"

mise install
