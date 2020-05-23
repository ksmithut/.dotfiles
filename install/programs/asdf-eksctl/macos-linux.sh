#!/usr/bin/env sh

. $HOME/.asdf/asdf.sh

asdf plugin add eksctl
asdf install eksctl latest
asdf global eksctl "$(asdf latest eksctl)"
