#!/usr/bin/env bash

if is_macos; then
  brew cask install tableplus
fi

if is_ubuntu; then
  # Add TablePlus gpg key
  wget -O - -q http://deb.tableplus.com/apt.tableplus.com.gpg.key | sudo apt-key add -

  # Add TablePlus repo
  sudo add-apt-repository "deb [arch=amd64] https://deb.tableplus.com/debian tableplus main"

  # Install
  sudo apt update -y
  sudo apt install -y tableplus
fi
