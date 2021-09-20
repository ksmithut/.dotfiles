#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh

asdf plugin add kubectx
asdf install kubectx latest
asdf global kubectx "$(asdf latest kubectl)"
