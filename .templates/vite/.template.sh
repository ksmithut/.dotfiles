#!/usr/bin/env sh

npm pkg set scripts.build="vite build"
npm pkg set scripts.dev="vite"

yarn add react react-dom clsx

yarn add -D \
  vite @vitejs/plugin-react @types/babel__core \
  @types/react @types/react-dom \
  tailwindcss postcss autoprefixer \
  typescript @types/node

echo '/public' >> .gitignore
