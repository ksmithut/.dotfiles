# Sets up linting for a node project
function setup-linting() {
  yarn add -D standard;
  cat package.json \
    | jq -M '.eslintConfig.root = true' \
    | jq -M '.eslintConfig.extends = ["standard"]' \
    | tee package.json &>/dev/null
}
# Sets up linting for a react project
function setup-linting-react() {
  yarn add -D standard babel-eslint;
  cat package.json \
    | jq -M '.eslintConfig.root = true' \
    | jq -M '.eslintConfig.parser = "babel-eslint"' \
    | jq -M '.eslintConfig.extends = ["standard","standard-jsx"]' \
    | tee package.json &>/dev/null
}
# Sets up testing for a typical javascript project
function setup-testing() {
  yarn add -D jest @types/jest;
  cat package.json \
    | jq -M '.jest.collectCoverage = true' \
    | tee package.json &>/dev/null
}

alias upgrade-interactive='npx npm-upgrade'
