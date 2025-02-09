FROM node:20-slim

# Устанавливаем зависимости для сборки Strapi и sharp
RUN apt update && apt install -y \
  build-essential \
  gcc \
  autoconf \
  automake \
  zlib1g-dev \
  libpng-dev \
  nasm \
  bash \
  libvips-dev \
  git \
  && rm -rf /var/lib/apt/lists/*

# Определяем рабочую директорию
WORKDIR /opt/

# Копируем package.json и lock-файл перед установкой зависимостей
COPY package.json package-lock.json ./

# Устанавливаем зависимости
RUN npm config set fetch-retry-maxtimeout 600000 -g && npm install

# Добавляем путь к бинарным файлам npm в переменную PATH
ENV PATH=/opt/node_modules/.bin:$PATH

# Устанавливаем рабочую директорию для кода проекта
WORKDIR /opt/app

# Копируем весь код проекта в контейнер
COPY . .

# Меняем владельца папки /opt/app на пользователя node
RUN chown -R node:node /opt/app

# Переключаемся на пользователя node (безопасность)
USER node

# Пересобираем @swc/core и esbuild
RUN npm rebuild @swc/core esbuild

# Собираем Strapi
RUN ["npm", "run", "build"]

# Открываем порт 1337
EXPOSE 1337

# Запускаем Strapi в режиме разработки
CMD ["npm", "run", "develop"]
