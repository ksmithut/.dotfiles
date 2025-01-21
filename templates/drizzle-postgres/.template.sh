#!/usr/bin/env sh

npm install \
  drizzle-orm pg drizzle-kit

npm install --save-dev \
  @types/pg

npm pkg set scripts.docker:up="docker compose up --remove-orphans --detach --renew-anon-volumes"
npm pkg set scripts.docker:down="docker compose down --remove-orphans --volumes"
npm pkg set scripts.db:push="node --env-file .env ./node_modules/.bin/drizzle-kit push"
npm pkg set scripts.db:generate="node --env-file .env ./node_modules/.bin/drizzle-kit generate"
npm pkg set scripts.db:migrate="node --env-file .env ./node_modules/.bin/drizzle-kit migrate"
npm pkg set scripts.db:studio="node --env-file .env ./node_modules/.bin/drizzle-kit studio"
