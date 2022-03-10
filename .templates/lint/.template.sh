#!/usr/bin/env sh

yarn add -D \
  @ksmithut/prettier-standard \
  standard

npm set-script 'format' 'prettier-standard --lint'
npm set-script 'lint' 'prettier-standard --check --lint'
