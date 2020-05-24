#!/usr/bin/env bash

# UPDATE_VERSION

wget https://github.com/BoostIO/boost-releases/releases/download/v0.15.3/boostnote_0.15.3_amd64.deb -O "$DOTFILES_INSTALLERS/boostnote.deb"
sudo dpkg -i "$DOTFILES_INSTALLERS/boostnote.deb"
sudo apt-get install -f -y
