#!/usr/bin/env bash

# UPDATE_VERSION - https://slack.com/downloads/instructions/ubuntu

wget 'https://downloads.slack-edge.com/releases/linux/4.20.0/prod/x64/slack-desktop-4.20.0-amd64.deb' -O "$DOTFILES_INSTALLERS/slack.deb"
sudo dpkg -i "$DOTFILES_INSTALLERS/slack.deb"
sudo apt-get install -f -y
