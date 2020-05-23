#!/usr/bin/env sh

# UPDATE_VERSION

wget https://github.com/BoostIO/boost-releases/releases/download/v0.15.3/boostnote_0.15.3_amd64.deb -O "$TEMP_DIR/caches/installers/boostnote.deb"
sudo dpkg -i "$TEMP_DIR/caches/installers/boostnote.deb"
sudo apt-get install -f -y
