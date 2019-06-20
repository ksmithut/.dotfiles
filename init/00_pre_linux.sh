#!/usr/bin/env bash
# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

sudo chown -R "$USER":"$USER" /usr/local/bin/

sudo apt-get update -y
sudo apt-get upgrade -y

# flatpak
sudo apt-get install -y snapd
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
