#!/usr/bin/env sh

npm pkg set scripts.format="prettier-standard --lint"
npm pkg set scripts.lint="prettier-standard --check --lint"

yarn add -D \
  @ksmithut/prettier-standard \
  standard

