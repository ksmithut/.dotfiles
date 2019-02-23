#!/usr/bin/env bash

eval "$(gpg-agent --daemon > /dev/null 2>&1)"
GPG_TTY=$(tty)
export GPG_TTY

echo "Choose an email address that is tied to your github account"
gpg --full-generate-key

KEY_ID="$(gpg --list-secret-keys --keyid-format LONG | grep 'sec   ' | tail -1 | sed -n 's/.*\/\([^ ]*\) .*/\1/p')"

if is_macos; then
  gpg --armor --export "$KEY_ID" | pbcopy
elif is_ubuntu || is_debian; then
  gpg --armor --export "$KEY_ID" | xclip -selection clipboard
fi

if is_macos; then
  open https://github.com/settings/keys
elif is_ubuntu || is_debian; then
  xdg-open https://github.com/settings/keys &>/dev/null
fi

echo 'press enter once you have pasted it in'
# shellcheck disable=SC2034
read -r CONTINUE

if is_ubuntu || is_debian; then
  echo 'pinentry-program /usr/bin/pinentry-curses' >  ~/.gnupg/gpg-agent.conf
fi
