#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh

asdf plugin add kubectl
asdf install kubectl latest
asdf global kubectl "$(asdf latest kubectl)"
