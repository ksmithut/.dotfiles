#!/usr/bin/env bash

# Skip gpg until I figure out how to do subkeys properly
return

# eval "$(gpg-agent --daemon > /dev/null 2>&1)"
# GPG_TTY=$(tty)
# export GPG_TTY

# echo "Choose an email address that is tied to your github account"
# gpg --full-generate-key

# KEY_ID="$(gpg --list-secret-keys --keyid-format LONG | grep 'sec   ' | tail -1 | sed -n 's/.*\/\([^ ]*\) .*/\1/p')"

# echo ''
# echo 'Open https://github.com/settings/keys'
# echo 'press enter once you have signed into github'
# # shellcheck disable=SC2034
# read -r CONTINUE

# if [[ "${IS_MACOS}" == "1" ]]; then
#   gpg --armor --export "$KEY_ID" | pbcopy
# elif [[ "${IS_LINUX}" == "1" ]]; then
#   gpg --armor --export "$KEY_ID" | xclip -selection clipboard
# fi

# echo 'The gpg key has been copied to your clipboard.'
# echo 'press enter once you have pasted it in'
# # shellcheck disable=SC2034
# read -r CONTINUE

# if is_macos; then
#   echo 'pinentry-program /usr/local/bin/pinentry-mac' > ~/.gnupg/gpg-agent.conf
# elif is_ubuntu; then
#   echo 'pinentry-program /usr/bin/pinentry-curses' >  ~/.gnupg/gpg-agent.conf
# fi
