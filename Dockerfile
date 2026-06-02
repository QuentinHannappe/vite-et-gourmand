FROM php:8.4-cli

RUN apt-get update && apt-get install -y \
    git zip unzip curl libssl-dev pkg-config libpq-dev \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb \
    && docker-php-ext-install pdo pdo_pgsql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER=1

WORKDIR /app
COPY . .

RUN composer install --no-dev --optimize-autoloader --no-scripts --ignore-platform-req=ext-mongodb

ENV APP_ENV=prod

EXPOSE 8080
CMD php -S 0.0.0.0:8080 -t public/