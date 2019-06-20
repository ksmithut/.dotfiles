#!/usr/bin/env bash
# sets up the git config
echo -n 'github username: '; read -r GITHUB_USER
echo -n 'github email: '; read -r GITHUB_EMAIL
echo

[[ $GITHUB_USER != "" ]] && git config --global user.name "$GITHUB_USER"
[[ $GITHUB_EMAIL != "" ]] && git config --global user.email "$GITHUB_EMAIL"

return
GPG_SIGNING_KEY="$(gpg --list-secret-keys --keyid-format LONG | grep 'sec   ' | tail -1 | sed -n 's/.*\/\([^ ]*\) .*/\1/p')"
if [ "${GPG_SIGNING_KEY}" != "" ]; then
  git config --global user.signingkey "$GPG_SIGNING_KEY"
  git config --global gpg.program gpg
  git config --global commit.gpgsign true
fi
