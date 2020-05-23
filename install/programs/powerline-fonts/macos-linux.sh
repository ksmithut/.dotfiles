#!/usr/bin/env bash

echo 'Installing powerline fonts...'
mkdir -p "$TEMP_DIR/caches/fonts"
git clone https://github.com/powerline/fonts.git --depth=1 "$TEMP_DIR/caches/fonts/powerline-fonts"
"$TEMP_DIR/caches/fonts/powerline-fonts/install.sh"
