#!/usr/bin/env sh

npm pkg set scripts.format="dprint fmt"
npm pkg set scripts.lint="standard && dprint check"

yarn add -D dprint standard
