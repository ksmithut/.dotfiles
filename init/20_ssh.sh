#!/usr/bin/env bash
# Sets up ssh keys
echo -n 'ssh key email (make it the github email if you wish to use with github): '; read -r SSH_EMAIL
echo -n 'ssh key filename (id_rsa): '; read -r SSH_FILENAME
echo -n 'ssh key host (*): '; read -r SSH_HOST

[[ $SSH_FILENAME == "" ]] && SSH_FILENAME="id_rsa"
[[ $SSH_HOST == "" ]] && SSH_HOST="*"
SSH_PATH="${HOME}/.ssh/${SSH_FILENAME}"

ssh-keygen -t rsa -C "${SSH_EMAIL}" -f "${SSH_PATH}"

echo
echo 'Open "https://github.com/settings/keys"'
echo
echo '=== vvv Copy everything below vvv ==='
cat "${SSH_PATH}.pub"
echo
echo '=== ^^^ Copy everything above ^^^ ==='
echo
echo 'press enter once you have entered it'
# shellcheck disable=SC2034
read -r CONTINUE

# pbcopy < "${SSH_PATH}.pub"
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
