#!/usr/bin/env bash

if is_macos; then
  brew cask install balenaetcher
fi


if is_ubuntu; then
  echo "Fun fact #1 - Did you know that Pop!_OS ships with it's own USB flasher called: 'Popsicle'?"

  # Add Etcher debian repository:
  echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list

  # Trust Bintray.com's GPG key:
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61

  # Update & Install
  sudo apt-get update -y && sudo apt-get install -y balena-etcher-electron

  ## Uninstall
  # sudo apt-get remove balena-etcher-electron
  # sudo rm /etc/apt/sources.list.d/balena-etcher.list
  # sudo apt-get update

fi
