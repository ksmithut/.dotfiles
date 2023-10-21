#!/usr/bin/env sh

npm pkg set scripts.prepare="husky install || true"

npm add --save-dev \
  husky \
  lint-staged

npx husky add .husky/pre-commit 'npx lint-staged'
