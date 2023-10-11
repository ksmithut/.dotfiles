#!/usr/bin/env sh

npm pkg set scripts.prettier:format="prettier --write"
npm pkg set scripts.prettier:lint="prettier --check"

yarn add -D prettier
