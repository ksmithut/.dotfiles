#!/usr/bin/env bash

wget 'https://launcher.mojang.com/download/Minecraft.deb' -O "$DOTFILES_INSTALLERS/minecraft.deb"
sudo dpkg -i "$DOTFILES_INSTALLERS/minecraft.deb"
sudo apt-get install -f -y
