#!/usr/bin/env sh

sudo apt-add-repository -y ppa:yubico/stable
sudo apt update -y
sudo apt install -y yubikey-manager
