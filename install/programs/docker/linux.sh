#!/usr/bin/env bash



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
  focal \
  stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker "$USER"

# UPDATE_VERSION - https://github.com/docker/compose/releases

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/2.0.1/docker-compose-$(uname -s)-$(uname -m)" -o "$HOME"/.docker/cli-plugins/docker-compose
sudo chmod +x "$HOME"/.docker/cli-plugins/docker-compose
