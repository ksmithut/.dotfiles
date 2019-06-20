#!/usr/bin/env bash
# Ubuntu-only stuff. Abort if not Ubuntu.
is_linux || return 1

sudo chown -R "$USER":"$USER" /usr/local/bin/

sudo apt-get update -y
sudo apt-get upgrade -y

# flatpak
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# snap is already installed on ubuntu
if is_debian || is_pop_desktop; then
  sudo apt-get install -y snapd
fi
