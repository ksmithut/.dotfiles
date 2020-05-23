#!/usr/bin/env bash

wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb -O "$TEMP_DIR/caches/installers/steam.deb"
sudo dpkg -i "$TEMP_DIR/caches/installers/steam.deb"
sudo apt-get install -f -y
