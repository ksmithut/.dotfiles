#!/usr/bin/env sh

npm pkg set scripts.format="dprint fmt"
npm pkg set scripts.lint="standard && dprint check"
npm pkg set scripts.dprint:update="dprint config update"

yarn add -D dprint standard

yarn dprint config update
