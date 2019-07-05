#!/usr/bin/env bash

if is_macos; then
  brew tap jesseduffield/lazydocker
  brew install lazydocker
fi

if is_ubuntu; then
  # Waiting for https://github.com/jesseduffield/lazydocker/issues/95
fi
