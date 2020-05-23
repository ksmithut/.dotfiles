#!/usr/bin/env bash

sudo apt-get install dconf-cli
git clone https://github.com/dracula/gnome-terminal "$TEMP_DIR/caches/installers/dracula-gnome-terminal"
cd "$TEMP_DIR/caches/installers/dracula-gnome-terminal"
./install.sh
cd -
