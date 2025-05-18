#!/usr/bin/env sh

npm pkg set scripts.format="prettier --write ."
npm pkg set scripts.lint="prettier --check ."

if [ -f "bun.lock" ]; then
  bun install --dev prettier
else
  npm install --save-dev prettier
fi
