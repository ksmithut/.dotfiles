#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh

asdf plugin add fluxctl
asdf install fluxctl latest
asdf global fluxctl "$(asdf latest fluxctl)"
