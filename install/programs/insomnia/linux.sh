#!/usr/bin/env bash

# sudo snap install insomnia
wget 'https://updates.insomnia.rest/downloads/ubuntu/latest' -O "$TEMP_DIR/caches/installers/insomnia.deb"
sudo dpkg -i "$TEMP_DIR/caches/installers/insomnia.deb"
sudo apt-get install -f -y
