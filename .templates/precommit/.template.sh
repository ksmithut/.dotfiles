#!/usr/bin/env sh

yarn add -D \
  husky \
  lint-staged

npm set-script 'prepare' 'husky install || true'
yarn prepare
yarn husky add .husky/pre-commit 'npx lint-staged'
