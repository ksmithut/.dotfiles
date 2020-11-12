#!/usr/bin/env bash

# UPDATE_VERSION - https://github.com/BoostIO/boost-releases/releases

wget https://github.com/BoostIO/boost-releases/releases/download/v0.16.1/boostnote_0.16.1_amd64.deb -O "$DOTFILES_INSTALLERS/boostnote.deb"
sudo dpkg -i "$DOTFILES_INSTALLERS/boostnote.deb"
sudo apt-get install -f -y
