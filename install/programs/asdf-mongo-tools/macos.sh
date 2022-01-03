#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh

asdf plugin add golang
asdf install golang 1.15.15
asdf global golang 1.15.15

asdf plugin add mongo-tools
asdf install mongo-tools latest
asdf global mongo-tools "$(asdf latest mongo-tools)"

asdf install golang latest
asdf global golang "$(asdf latest golang)"
