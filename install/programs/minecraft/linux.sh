#!/usr/bin/env sh

wget 'https://launcher.mojang.com/download/Minecraft.deb' -O "$TEMP_DIR/caches/installers/minecraft.deb"
sudo dpkg -i "$TEMP_DIR/caches/installers/minecraft.deb"
sudo apt-get install -f -y
