#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh

asdf plugin add mongo-tools
asdf install mongo-tools latest
asdf global mongo-tools "$(asdf latest mongo-tools)"
