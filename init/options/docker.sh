#!/usr/bin/env bash

if is_macos; then
  brew cask install docker
fi

if is_ubuntu; then
  # Docker
  # Remove prior versions
  sudo apt-get remove docker docker-engine docker.io containerd runc
  # install docker
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io
  sudo usermod -aG docker "$USER"

  # install docker-compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

if is_windows; then
  choco install -y docker-desktop
fi
