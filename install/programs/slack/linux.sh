#!/usr/bin/env bash

# UPDATE_VERSION

wget 'https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.2-amd64.deb' -O "$TEMP_DIR/caches/installers/slack.deb"
sudo dpkg -i "$TEMP_DIR/caches/installers/slack.deb"
sudo apt-get install -f -y
