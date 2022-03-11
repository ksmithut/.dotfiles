#!/usr/bin/env sh

npm set-script 'build' 'vite build'
npm set-script 'dev' 'vite'

npm set-script 'format' 'prettier-standard --lint'
npm set-script 'lint' 'prettier-standard --check --lint'

yarn add react react-dom clsx

yarn add -D \
  vite @vitejs/plugin-react @types/babel__core \
  @types/react @types/react-dom \
  tailwindcss postcss autoprefixer \
  @ksmithut/prettier-standard standard \
  typescript

echo '/public' >> .gitignore
