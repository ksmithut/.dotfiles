#!/usr/bin/env sh

npm set-script 'build' 'vite build'
npm set-script 'client:dev' 'vite'
npm set-script 'dev' 'run-p --print-label start:dev client:dev'

yarn add -D \
  vite @vitejs/plugin-react @types/babel__core \
  react @types/react \
  react-dom @types/react-dom \
  npm-run-all \
  tailwindcss postcss autoprefixer \
  clsx
