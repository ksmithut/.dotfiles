#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh

asdf plugin add krew
asdf install krew latest
asdf global krew "$(asdf latest krew)"
