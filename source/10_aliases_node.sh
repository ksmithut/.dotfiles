
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
    | tee package.json
}
# Sets up linting for a react project
function setup_linting_react() {
  yarn add -D standard;
  cat package.json \
    | jq -M '.eslintConfig.root = true' \
    | jq -M '.eslintConfig.extends = ["standard","standard-jsx"]' \
    | tee package.json
}

function setup_testing() {
  yarn add -D jest;
  cat package.json \
    | jq -M '.jest.collectCoverage = true' \
    | tee package.json
}

function setup_react_project() {
  yarn add react react-dom prop-types classnames
  yarn add -D react-scripts
  cat package.json \
    | jq -M '.scripts.start = "react-scripts start"' \
    | jq -M '.scripts.test = "react-scripts test"' \
    | jq -M '.scripts.build = "react-scripts build"' \
    | tee package.json
  mkdir -p public src/components src/pages
  # public/index.html
  echo \
'<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title></title>
</head>

<body>
  <div id="root"></div>
</body>

</html>
' > public/index.html
  # src/App.js
  echo \
"import React from 'react'
import ReactDOM from 'react-dom'
import App from './App'

ReactDOM.render(<App />, document.getElementById('root'))
" > src/index.js
echo \
"import React from 'react'

class App extends React.Component {
  render() {
    return <h1>Hello World</h1>
  }
}

export default App
" > src/App.js
  setup_linting_react
}
