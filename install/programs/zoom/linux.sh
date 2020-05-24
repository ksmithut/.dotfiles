#!/usr/bin/env bash

wget https://zoom.us/client/latest/zoom_amd64.deb -O "$DOTFILES_INSTALLERS/zoom.deb"
sudo dpkg -i "$DOTFILES_INSTALLERS/zoom.deb"
sudo apt-get install -f -y
