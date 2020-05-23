#!/usr/bin/env sh

. $HOME/.asdf/asdf.sh

asdf plugin add kustomize
asdf install kustomize latest
asdf global kustomize "$(asdf latest kustomize)"
