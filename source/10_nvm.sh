export NVM_DIR=~/.nvm
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
export NODEJS_ORG_MIRROR="$NVM_NODEJS_ORG_MIRROR"

# Change version of node on cd
function _change_node_version() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
cd() { builtin cd "$@" && _change_node_version; }
pushd() { builtin pushd "$@" && _change_node_version; }
popd() { builtin popd "$@" && _change_node_version; }
_change_node_version # Change it when we start a new terminal
