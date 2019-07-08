#!/usr/bin/env bash

if is_macos; then
  echo 'VLC is only available for linux at this time.'
fi

if is_ubuntu; then
  # sudo snap install vlc
  # flatpak install -y flathub org.videolan.VLC
  sudo apt-get install -y vlc
fi
