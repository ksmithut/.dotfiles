#!/usr/bin/env bash

echo 'Now we are going to generate a new ssh key for this machine.'
echo ''

# Sets up ssh keys
echo -n 'ssh key email (make it the github email if you wish to use with github): '; read -r SSH_EMAIL
echo -n 'ssh key filename (id_github): '; read -r SSH_FILENAME
echo -n 'ssh key host (*): '; read -r SSH_HOST

[[ $SSH_FILENAME == "" ]] && SSH_FILENAME="id_github"
[[ $SSH_HOST == "" ]] && SSH_HOST="*"
SSH_PATH="${HOME}/.ssh/${SSH_FILENAME}"

ssh-keygen -t ed25519 -C "${SSH_EMAIL}" -f "${SSH_PATH}"

eval "$(ssh-agent -s > /dev/null 2>&1)"
if [[ "$OSTYPE" =~ ^darwin ]]; then
  ssh-add -K "${SSH_PATH}"
else
  ssh-add "${SSH_PATH}"
fi

if [[ "$OSTYPE" =~ ^darwin ]]; then
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
