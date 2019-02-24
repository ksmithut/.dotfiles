#!/usr/bin/env bash
# Sets up ssh keys
echo -n 'ssh key email (make it the github email if you wish to use with github): '; read -r SSH_EMAIL
echo -n 'ssh key filename (id_rsa): '; read -r SSH_FILENAME
echo -n 'ssh key host (*): '; read -r SSH_HOST

[[ $SSH_FILENAME == "" ]] && SSH_FILENAME="id_rsa"
[[ $SSH_HOST == "" ]] && SSH_HOST="*"
SSH_PATH="${HOME}/.ssh/${SSH_FILENAME}"

ssh-keygen -t rsa -C "${SSH_EMAIL}" -f "${SSH_PATH}"

if is_macos; then
  cat "${SSH_PATH}.pub" | pbcopy
elif is_ubuntu || is_debian; then
  cat "${SSH_PATH}.pub" | xclip -selection clipboard
fi

if is_macos; then
  open https://github.com/settings/keys
elif is_ubuntu || is_debian; then
  xdg-open https://github.com/settings/keys &>/dev/null
fi

echo 'press enter once you have pasted it in'
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
