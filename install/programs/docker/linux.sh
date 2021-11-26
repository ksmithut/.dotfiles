#!/usr/bin/env bash



sudo apt-get remove docker docker-engine docker.io containerd runc
# install docker
sudo apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker "$USER"

# UPDATE_VERSION - https://github.com/docker/compose/releases

# install docker-compose
# sudo curl -L "https://github.com/docker/compose/releases/download/2.0.1/docker-compose-$(uname -s)-$(uname -m)" -o "$HOME"/.docker/cli-plugins/docker-compose
# sudo chmod +x "$HOME"/.docker/cli-plugins/docker-compose
