#!/usr/bin/env sh

npm install --save-dev \
  @react-router/dev \
  @tailwindcss/vite \
  @types/node \
  @types/pg \
  @types/react \
  @types/react-dom \
  prettier \
  prettier-plugin-tailwindcss \
  tailwindcss \
  typescript \
  vite \
  vite-tsconfig-paths

npm install \
  @react-router/fs-routes \
  @react-router/node \
  @react-router/serve \
  drizzle-kit \
  drizzle-orm \
  isbot \
  pg \
  react \
  react-dom \
  react-router

npx react-router typegen
mkdir drizzle

git init
