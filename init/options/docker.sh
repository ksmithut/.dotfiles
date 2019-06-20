#!/usr/bin/env bash

if is_macos; then
  brew cask install docker
fi

if is_ubuntu; then
  # Docker
  # Remove prior versions
  sudo apt-get remove docker docker-engine docker.io containerd runc
  # install docker
  curl -fsSL get.docker.com -o get-docker.sh
  chmod a+x get-docker.sh
  sudo sh get-docker.sh
  rm get-docker.sh
  sudo usermod -aG docker "$USER"

  # install docker-compose
  sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-"$(uname -s)"-"$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi
