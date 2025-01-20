FROM node:18-alpine3.18
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev git
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt
COPY package.json pnpm-lock.yaml ./
RUN npm i -g pnpm
RUN npm install -g node-gyp
RUN pnpm config set fetch-retry-maxtimeout 600000 -g && pnpm install && pnpm install pg
ENV PATH=/opt/node_modules/.bin:$PATH

WORKDIR /opt/app
COPY . .
RUN chown -R node:node /opt/app
USER node
RUN ["pnpm", "run", "build"]
EXPOSE 1337
CMD ["pnpm", "run", "develop"]
