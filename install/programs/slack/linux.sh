#!/usr/bin/env bash

# UPDATE_VERSION - https://slack.com/downloads/instructions/ubuntu

wget 'https://downloads.slack-edge.com/linux_releases/slack-desktop-4.11.1-amd64.deb' -O "$DOTFILES_INSTALLERS/slack.deb"
sudo dpkg -i "$DOTFILES_INSTALLERS/slack.deb"
sudo apt-get install -f -y
