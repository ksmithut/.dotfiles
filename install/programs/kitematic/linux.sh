#!/usr/bin/env sh

# UPDATE_VERSION

wget https://github.com/docker/kitematic/releases/download/v0.17.11/Kitematic-0.17.11-Ubuntu.zip -O kitematic.zip
unzip kitematic.zip -d "$TEMP_DIR/caches/installers/kitematic"
rm kitematic.zip
sudo dpkg -i "$TEMP_DIR/caches/installers/kitematic/Kitematic-0.17.11_amd64.deb"
sudo apt-get install -f -y
