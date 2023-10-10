#!/usr/bin/env zsh

# reverts to a given commit
oh-crap () {
  if [[ "$1" == "" ]]; then
    echo 'You must pass in a commit id'
    return 1
  fi
  git reset --hard "$1"
  git reset --soft "HEAD@{1}"
  git commit -m "Revert to $1"
}

clone () {
  if [[ "$1" == "" ]]; then
    echo 'You must pass in a repo name'
    return 1
  fi
  if [[ "$1" != git@* ]] && [[ "$1" != https://* ]]; then
    1="git@github.com:${1}"
  fi
  if [[ "$2" != "" ]]; then
    git clone $1 $2
    return 0
  fi
  local folder_name="$(node -p "process.argv[1].replace(/^(git@|https:\/\/)/, '').replace(/\.git$/, '').split(/[:\/]/).join(path.sep)" $1)"
  local full_path=~/Code/"$folder_name"
  mkdir -p "$full_path"
  git clone "$1" "$full_path"
  cd "$full_path"
}

alias -s git=clone

git-user () {
  if [[ "$#" -eq 3 ]]; then
    local cwd="$(pwd | sed "s#^${HOME}#~#")"
    local org_config_path="~/.${1}.gitconfig"
    local full_config_path="${HOME}/.${1}.gitconfig"
    touch "${full_config_path}"
    git config --file "${full_config_path}" user.name "${2}"
    git config --file "${full_config_path}" user.email "${3}"
    echo "[includeIf \"gitdir:${cwd}\"]
	path = ${org_config_path}" >> ~/.gitconfig
    echo
    echo ".gitconfig"
    echo
    cat ~/.gitconfig
    echo
    echo "${org_config_path}"
    echo
    cat "${full_config_path}"
  else
    echo 'Usage: git-user <org-name> <user-name> <user-email>'
    return 1
  fi
}
