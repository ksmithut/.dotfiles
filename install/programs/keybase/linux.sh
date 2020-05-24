#!/usr/bin/env bash

# There is a snap for it, but it needs to be installed with the edge flag
wget https://prerelease.keybase.io/keybase_amd64.deb -O "$DOTFILES_INSTALLERS/keybase.deb"
sudo dpkg -i "$DOTFILES_INSTALLERS/keybase.deb"
sudo apt-get install -f -y
