#!/usr/bin/env sh

. $HOME/.asdf/asdf.sh

asdf plugin add helm
asdf install helm latest
asdf global helm "$(asdf latest helm)"
