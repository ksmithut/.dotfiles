#!/usr/bin/env bash

wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb -O "$DOTFILES_INSTALLERS/steam.deb"
sudo dpkg -i "$DOTFILES_INSTALLERS/steam.deb"
sudo apt-get install -f -y
