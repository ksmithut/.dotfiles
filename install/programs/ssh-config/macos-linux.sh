#!/usr/bin/env bash

echo 'Now we are going to generate a new ssh key for this machine.'
echo ''

# Sets up ssh keys
echo -n 'ssh key email (make it the github email if you wish to use with github): '; read -r SSH_EMAIL
echo -n 'ssh key filename (id_rsa): '; read -r SSH_FILENAME
echo -n 'ssh key host (*): '; read -r SSH_HOST

[[ $SSH_FILENAME == "" ]] && SSH_FILENAME="id_rsa"
[[ $SSH_HOST == "" ]] && SSH_HOST="*"
SSH_PATH="${HOME}/.ssh/${SSH_FILENAME}"

ssh-keygen -t rsa -C "${SSH_EMAIL}" -f "${SSH_PATH}"

echo ''
echo 'Open https://github.com/settings/keys'
echo 'press enter once you have signed into github'
# shellcheck disable=SC2034
read -r CONTINUE

if [[ "${IS_MACOS}" == "1" ]]; then
  pbcopy < "${SSH_PATH}.pub"
elif [[ "${IS_LINUX}" == "1" ]]; then
  xclip -selection clipboard < "${SSH_PATH}.pub"
fi

echo 'The public ssh key has been copied to your clipboard.'
echo 'press enter once you have pasted it in'
# shellcheck disable=SC2034
read -r CONTINUE

eval "$(ssh-agent -s > /dev/null 2>&1)"
if is_macos; then
  ssh-add -K "${SSH_PATH}"
else
  ssh-add "${SSH_PATH}"
fi

if is_macos; then
  echo "
Host ${SSH_HOST}
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/${SSH_FILENAME}
" >> ~/.ssh/config
else
  echo "
Host ${SSH_HOST}
  AddKeysToAgent yes
  IdentityFile ~/.ssh/${SSH_FILENAME}
" >> ~/.ssh/config
fi
