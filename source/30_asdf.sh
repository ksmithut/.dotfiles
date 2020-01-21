#!/usr/bin/env bash

ASDF_DIR="$HOME/.asdf"
if is_macos; then
  ASDF_DIR="$(brew --prefix asdf)"
fi

if [[ -s "$ASDF_DIR/asdf.sh" ]]; then
  . "$ASDF_DIR"/asdf.sh
  . "$ASDF_DIR"/completions/asdf.bash
fi
