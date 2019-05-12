#!/usr/bin/env bash
# Debian-only stuff.
is_debian || return 1

sudo add-apt-repository -y ppa:alexlarsson/flatpak
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y \
  autojump \
  build-essential \
  buku \
  curl \
  flatpak \
  gvfs-bin \
  jq \
  libgconf-2-4 \
  neofetch \
  oathtool \
  python \
  ruby \
  trash-cli \
  tree \
  vim \
  wget \
  xclip \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common \
  tmux \
  chromium \
  zsh

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y com.slack.Slack
flatpak install -y com.visualstudio.code
flatpak install -y com.discordapp.Discord
flatpak install -y com.getpostman.Postman

# Boostnote
wget https://github.com/BoostIO/boost-releases/releases/download/v0.11.15/boostnote_0.11.15_amd64.deb -O "$DOTFILES/caches/installers/boostnote.deb"
sudo dpkg -i "$DOTFILES/caches/installers/boostnote.deb"
sudo apt-get install -f -y

# Insomnia
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
| sudo tee -a /etc/apt/sources.list.d/insomnia.list
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
| sudo apt-key add -
sudo apt-get update
sudo apt-get install insomnia

# Keybase
wget https://prerelease.keybase.io/keybase_amd64.deb -O "$DOTFILES/caches/installers/keybase.deb"
sudo dpkg -i "$DOTFILES/caches/installers/keybase.deb"
sudo apt-get install -f -y

# Docker
sudo apt-get remove docker docker-engine docker.io containerd runc
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) \
  stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker "$USER"

# docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-"$(uname -s)"-"$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install -y --no-install-recommends yarn

sudo apt-get autoremove -y

# Erlang/Elixir
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -O "$DOTFILES/caches/installers/erlang.deb"
sudo dpkg -i "$DOTFILES/caches/installers/erlang.deb"
sudo apt-get update
sudo apt-get install -y esl-erlang
sudo apt-get install -y elixir

# SDKMan!
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
