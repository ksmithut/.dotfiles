#!/usr/bin/env bash

sudo apt-get install -y dconf-cli
git clone https://github.com/dracula/gnome-terminal "$DOTFILES_INSTALLERS/dracula-gnome-terminal"
cd "$DOTFILES_INSTALLERS/dracula-gnome-terminal"
./install.sh
cd -
