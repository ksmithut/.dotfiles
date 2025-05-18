#!/usr/bin/env sh

bun install --dev \
  @types/bun \
  @types/react \
  @types/react-dom \
  prettier \
  prettier-plugin-tailwindcss \
  typescript \

bun install \
  bun-plugin-tailwind \
  react \
  react-dom \
  tailwindcss
