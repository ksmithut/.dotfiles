#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh

asdf plugin add lazydocker https://github.com/comdotlinux/asdf-lazydocker.git
asdf install lazydocker latest
asdf global lazydocker "$(asdf latest lazydocker)"
