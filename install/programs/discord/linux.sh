#!/usr/bin/env bash

wget 'https://discordapp.com/api/download?platform=linux&format=deb' -O "$DOTFILES_INSTALLERS/discord.deb"
sudo dpkg -i "$DOTFILES_INSTALLERS/discord.deb"
sudo apt-get install -f -y
