#!/usr/bin/env bash

if is_macos; then
  brew tap jesseduffield/lazydocker
  brew install lazydocker
fi

if is_ubuntu; then
  curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
fi
