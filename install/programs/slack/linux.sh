#!/usr/bin/env bash

# UPDATE_VERSION

wget 'https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.2-amd64.deb' -O "$DOTFILES_INSTALLERS/slack.deb"
sudo dpkg -i "$DOTFILES_INSTALLERS/slack.deb"
sudo apt-get install -f -y
