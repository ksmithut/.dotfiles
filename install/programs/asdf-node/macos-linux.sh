#!/usr/bin/env bash

. $HOME/.asdf/asdf.sh

asdf plugin add nodejs
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs latest
asdf global nodejs "$(asdf latest nodejs)"

asdf plugin add yarn
asdf install yarn latest
asdf global yarn "$(asdf latest yarn)"

echo 'legacy_version_file = yes' >> ~/.asdfrc
