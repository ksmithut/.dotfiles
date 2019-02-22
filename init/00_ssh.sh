#!/usr/bin/env bash
# Sets up ssh keys
echo -n 'ssh key email: '; read -r SSH_EMAIL
echo -n 'ssh key filename (id_rsa): '; read -r SSH_FILENAME
echo -n 'ssh key host (*): '; read -r SSH_HOST

[[ $SSH_FILENAME == "" ]] && SSH_FILENAME="id_rsa"
[[ $SSH_HOST == "" ]] && SSH_HOST="*"
SSH_PATH="${HOME}/.ssh/${SSH_FILENAME}"

ssh-keygen -t rsa -C "${SSH_EMAIL}" -f "${SSH_PATH}"

echo -n 'Open "https://github.com/settings/keys", press enter here when logged in '; read -r
pbcopy < "${SSH_PATH}.pub"
echo 'public key copied to clipboard, paste into new ssh key'

eval "$(ssh-agent -s > /dev/null 2>&1)"
if is_macos; then
  ssh-add -K "${SSH_PATH}"
else
  ssh-add "${SSH_PATH}"
fi

echo "
Host ${SSH_HOST}
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/${SSH_FILENAME}
" >> ~/.ssh/config
