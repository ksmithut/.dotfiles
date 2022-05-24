#!/usr/bin/env sh

npm set-script 'format' 'dprint fmt'
npm set-script 'lint' 'standard && dprint check'

yarn add -D \
  dprint \
  standard
