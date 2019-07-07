#!/usr/bin/env bash

if is_macos; then
  brew cask install slack
fi

if is_ubuntu; then
  sudo snap install slack --classic
  # flatpak install -y flathub com.slack.Slack
fi

if is_windows; then
  choco install -y slack
fi
