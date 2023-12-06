#!/usr/bin/env sh

npm pkg set scripts.format="prettier --write ."
npm pkg set scripts.lint="prettier --check . && tsc"

npm install --save-dev prettier
