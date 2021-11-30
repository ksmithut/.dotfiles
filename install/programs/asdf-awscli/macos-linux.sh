#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh

asdf plugin add awscli
asdf install awscli latest
asdf global awscli "$(asdf latest awscli)"
