#!/usr/bin/env sh

npm pkg set scripts.prepare="husky install || true"

yarn add -D \
  husky \
  lint-staged

yarn husky add .husky/pre-commit 'npx lint-staged'
