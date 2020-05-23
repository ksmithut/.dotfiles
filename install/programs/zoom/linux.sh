#!/usr/bin/env bash

wget https://zoom.us/client/latest/zoom_amd64.deb -O "$TEMP_DIR/caches/installers/zoom.deb"
sudo dpkg -i "$TEMP_DIR/caches/installers/zoom.deb"
sudo apt-get install -f -y
