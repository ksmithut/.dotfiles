FROM node:22-alpine AS development-dependencies-env
COPY --chown=node:node package.json package-lock.json /app/
WORKDIR /app
USER node
RUN npm ci

FROM node:22-alpine AS production-dependencies-env
COPY --chown=node:node package.json package-lock.json /app/
WORKDIR /app
USER node
RUN npm ci --omit=dev

FROM node:22-alpine AS build-env
COPY --chown=node:node package.json package-lock.json react-router.config.ts tsconfig.json vite.config.ts /app/
COPY --chown=node:node app /app/app
COPY --chown=node:node public /app/public
COPY --chown=node:node --from=development-dependencies-env /app/node_modules /app/node_modules
WORKDIR /app
USER node
RUN npm run build

FROM node:22-alpine
COPY --chown=node:node package.json package-lock.json drizzle.config.ts /app/
COPY --chown=node:node drizzle /app/
COPY --chown=node:node --from=production-dependencies-env /app/node_modules /app/node_modules
COPY --chown=node:node --from=build-env /app/build /app/build
WORKDIR /app
USER node
CMD ["npm", "run", "start"]
