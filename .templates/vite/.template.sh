#!/usr/bin/env sh

npm pkg set scripts.build="vite build"
npm pkg set scripts.dev="vite"

npm pkg set scripts.format="prettier-standard --lint"
npm pkg set scripts.lint="prettier-standard --check --lint"

yarn add react react-dom clsx

yarn add -D \
  vite @vitejs/plugin-react @types/babel__core \
  @types/react @types/react-dom \
  tailwindcss postcss autoprefixer \
  @ksmithut/prettier-standard standard \
  typescript

echo '/public' >> .gitignore
