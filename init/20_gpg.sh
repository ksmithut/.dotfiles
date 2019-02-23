#!/usr/bin/env bash

eval "$(gpg-agent --daemon > /dev/null 2>&1)"
GPG_TTY=$(tty)
export GPG_TTY

echo "Choose an email address that is tied to your github account"
gpg --full-generate-key

KEY_ID="$(gpg --list-secret-keys --keyid-format LONG | grep 'sec   ' | tail -1 | sed -n 's/.*\/\([^ ]*\) .*/\1/p')"

if [ "${KEY_ID}" == "" ]; then
  echo
  echo 'Open "https://github.com/settings/keys"'
  echo
  echo '=== vvv Copy everything below vvv ==='
  gpg --armor --export "$KEY_ID"
  echo '=== ^^^ Copy everything above ^^^ ==='
  echo
  echo 'press enter once you have entered it'

  if is_ubuntu || is_debian; then
    echo 'pinentry-program /usr/bin/pinentry-curses' >  ~/.gnupg/gpg-agent.conf
  fi
fi
