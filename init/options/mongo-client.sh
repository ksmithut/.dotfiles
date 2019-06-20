#!/usr/bin/env bash

if is_macos; then
  brew cask install jeromelebel-mongohub
fi

if is_linux; then
  # TODO find a mongo client that's easy to install and that I like
fi
