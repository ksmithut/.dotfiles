#!/usr/bin/env sh

npm set-script 'format' 'prettier-standard --lint'
npm set-script 'lint' 'prettier-standard --check --lint'

yarn add -D \
  @ksmithut/prettier-standard \
  standard

