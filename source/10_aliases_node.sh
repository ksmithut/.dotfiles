
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

# Sets up linting for a node project
function setup_linting() {
  yarn add -D standard;
  cat package.json \
    | jq -M '.eslintConfig.root = true' \
    | jq -M '.eslintConfig.extends = ["standard"]' \
    | tee package.json &>/dev/null
}
# Sets up linting for a react project
function setup_linting_react() {
  yarn add -D standard babel-eslint;
  cat package.json \
    | jq -M '.eslintConfig.root = true' \
    | jq -M '.eslintConfig.parser = "babel-eslint"' \
    | jq -M '.eslintConfig.extends = ["standard","standard-jsx"]' \
    | tee package.json &>/dev/null
}
# Sets up testing for a typical javascript project
function setup_testing() {
  yarn add -D jest @types/jest;
  cat package.json \
    | jq -M '.jest.collectCoverage = true' \
    | tee package.json &>/dev/null
}
