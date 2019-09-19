#!/usr/bin/env bash

if is_ubuntu; then
  sudo add-apt-repository -y ppa:lutris-team/lutris
  sudo apt-get update -y
  sudo apt-get install -y lutris
fi
