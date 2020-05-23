#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh

asdf plugin add golang
asdf install golang latest
asdf global golang "$(asdf latest golang)"
