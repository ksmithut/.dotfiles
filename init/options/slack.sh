#!/usr/bin/env bash

if is_macos; then
  brew cask install slack
fi

if is_linux; then
  sudo snap install slack --classic
  # flatpak install -y com.slack.Slack
fi
