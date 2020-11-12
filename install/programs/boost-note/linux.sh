#!/usr/bin/env bash

wget https://github.com/BoostIO/BoostNote.next/releases/latest/download/boost-note-linux.deb -O "$DOTFILES_INSTALLERS/boost-note.deb"
sudo dpkg -i "$DOTFILES_INSTALLERS/boost-note.deb"
sudo apt-get install -f -y
