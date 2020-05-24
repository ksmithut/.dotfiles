#!/usr/bin/env bash

if is_macos; then
  brew cask install slack
fi

if is_ubuntu; then
  # sudo snap install slack --classic
  # flatpak install -y flathub com.slack.Slack
  wget 'https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.2-amd64.deb' -O "$DOTFILES_INSTALLERS/slack.deb"
  sudo dpkg -i "$DOTFILES_INSTALLERS/slack.deb"
  sudo apt-get install -f -y
fi

if is_windows; then
  choco install -y slack
fi
