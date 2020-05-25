#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh

asdf plugin add kops
asdf install kops latest
asdf global kops "$(asdf latest kops)"
