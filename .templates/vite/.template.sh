#!/usr/bin/env sh

yarn add -D \
  vite @vitejs/plugin-react \
  react @types/react \
  react-dom @types/react-dom \
  npm-run-all \
  tailwindcss postcss autoprefixer \
  clsx

npm set-script 'build' 'vite build'
npm set-script 'client:dev' 'vite'
npm set-script 'dev' 'run-p --print-label start:dev client:dev'
