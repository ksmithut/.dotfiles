#!/usr/bin/env bash

echo 'Installing powerline fonts...'
mkdir -p "$DOTFILES/caches/fonts"
git clone https://github.com/powerline/fonts.git --depth=1 "$DOTFILES/caches/fonts/powerline-fonts"
"$DOTFILES/caches/fonts/powerline-fonts/install.sh"
