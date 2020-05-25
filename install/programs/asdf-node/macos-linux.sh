#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh

asdf plugin add nodejs
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs latest:10
asdf install nodejs latest:12
asdf install nodejs latest:14
asdf install nodejs latest
asdf global nodejs "$(asdf latest nodejs)"

asdf plugin add yarn
asdf install yarn latest
asdf global yarn "$(asdf latest yarn)"
