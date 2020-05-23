#!/usr/bin/env sh

. $HOME/.asdf/asdf.sh

asdf plugin add skaffold
asdf install skaffold latest
asdf global skaffold "$(asdf latest skaffold)"
