#!/usr/bin/env bash

# sudo snap install insomnia
wget 'https://updates.insomnia.rest/downloads/ubuntu/latest' -O "$DOTFILES_INSTALLERS/insomnia.deb"
sudo dpkg -i "$DOTFILES_INSTALLERS/insomnia.deb"
sudo apt-get install -f -y
