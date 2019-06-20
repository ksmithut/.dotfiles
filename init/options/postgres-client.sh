#!/usr/bin/env bash

if is_macos; then
  brew cask install psequel
fi

if is_linux; then
  # TODO find a postgres client that's easy to install and that I like
fi
