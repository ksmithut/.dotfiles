#!/usr/bin/env bash

sudo apt-add-repository -y ppa:yubico/stable
sudo apt update -y
sudo apt install -y yubikey-manager
