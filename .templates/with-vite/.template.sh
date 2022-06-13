#!/usr/bin/env sh

npm pkg set scripts.build="vite build"
npm pkg set scripts.client:dev="vite"
npm pkg set scripts.dev="run-p --print-label start:dev client:dev"

yarn add -D \
  vite @vitejs/plugin-react @types/babel__core \
  react @types/react \
  react-dom @types/react-dom \
  npm-run-all \
  tailwindcss postcss autoprefixer \
  clsx

echo '/public' >> .gitignore
