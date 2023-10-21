#!/usr/bin/env sh

npm pkg set scripts.format="prettier --write ."
npm pkg set scripts.lint="prettier --check . && eslint . && tsc"

npm install --save-dev \
  prettier \
  eslint \
  eslint-config-standard \
  eslint-config-standard-jsx \
  eslint-config-prettier
