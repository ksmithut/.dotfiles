#!/usr/bin/env sh

yarn add -D \
  prisma

yarn prisma init --datasource-provider sqlite --url 'file:./dev.db'
echo '*.db' >> .gitignore
echo '*.db-journal' >> .gitignore
