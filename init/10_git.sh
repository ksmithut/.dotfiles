#!/usr/bin/env bash
# sets up the git config
echo -n 'github username: '; read -r GITHUB_USER
echo -n 'github email: '; read -r GITHUB_EMAIL
gpg --list-secret-keys --keyid-format LONG
echo -n 'gpg signing key: '; read -r GPG_SIGNING_KEY
echo

[[ $GITHUB_USER != "" ]] && git config --global user.name "$GITHUB_USER"
[[ $GITHUB_EMAIL != "" ]] && git config --global user.email "$GITHUB_EMAIL"
[[ $GPG_SIGNING_KEY != "" ]] && git config --global user.signingkey "$GPG_SIGNING_KEY"
