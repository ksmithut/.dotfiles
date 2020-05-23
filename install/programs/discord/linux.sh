#!/usr/bin/env bash

wget 'https://discordapp.com/api/download?platform=linux&format=deb' -O "$TEMP_DIR/caches/installers/discord.deb"
sudo dpkg -i "$TEMP_DIR/caches/installers/discord.deb"
sudo apt-get install -f -y
