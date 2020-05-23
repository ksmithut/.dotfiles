#!/usr/bin/env sh

. $HOME/.asdf/asdf.sh

asdf plugin add kubeseal
asdf install kubeseal latest
asdf global kubeseal "$(asdf latest kubeseal)"
