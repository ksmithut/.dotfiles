#!/usr/bin/env sh

# There is a snap for it, but it needs to be installed with the edge flag
wget https://prerelease.keybase.io/keybase_amd64.deb -O "$TEMP_DIR/caches/installers/keybase.deb"
sudo dpkg -i "$TEMP_DIR/caches/installers/keybase.deb"
sudo apt-get install -f -y
