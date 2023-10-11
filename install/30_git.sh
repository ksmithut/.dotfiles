#!/usr/bin/env bash
is-macos || is-linux || return

echo -n 'github username: '; read -r GITHUB_USER
echo -n 'github email: '; read -r GITHUB_EMAIL
echo

org="github"
filename=".gitconfig.${org}"
org_config_path="${HOME}/${filename}"
touch "${org_config_path}"
echo "org_config_path=${org_config_path}"
git config --file "${org_config_path}" user.name "${GITHUB_USER}"
git config --file "${org_config_path}" user.email "${GITHUB_EMAIL}"
echo "[includeIf \"gitdir:$(pwd)/\"]
	path = ${org_config_path}" >> ~/.gitconfig.includes

SSH_FILENAME="id_github"
SSH_HOST="github.com"
SSH_PATH="${HOME}/.ssh/${SSH_FILENAME}"

ssh-keygen -t ed25519 -C "${GITHUB_EMAIL}" -f "${SSH_PATH}"

eval "$(ssh-agent -s > /dev/null 2>&1)"
if [[ "$OSTYPE" =~ ^darwin ]]; then
  ssh-add --apple-use-keychain "${SSH_PATH}"
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

# id="$(awk '{ print $1, $2 }' ${SSH_PATH}.pub)"
# git config --global commit.gpgsign true
# git config --global gpg.format ssh
# git config --global user.signingkey "$(awk '{ print $1, $2 }' ${SSH_PATH}.pub)"
# git config --global gpg.ssh.allowedSignersFile ~/.ssh/allowed_signers
# echo "$(awk '{ print $3, $1, $2 }' ${SSH_PATH}.pub)" > ~/.ssh/allowed_signers

