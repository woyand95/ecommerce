FROM php:8.2-apache

# ── System-Pakete ───────────────────────────────────────────
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libjpeg-dev \
    libfreetype6-dev libonig-dev libxml2-dev \
    libzip-dev libicu-dev \
    && rm -rf /var/lib/apt/lists/*

# ── PHP-Extensions ──────────────────────────────────────────
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo pdo_mysql \
        mbstring \
        exif \
        pcntl \
        bcmath \
        gd \
        zip \
        intl \
        opcache

# ── Redis Extension ─────────────────────────────────────────
RUN pecl install redis && docker-php-ext-enable redis

# ── Apache: mod_rewrite aktivieren ──────────────────────────
RUN a2enmod rewrite

# ── Apache Virtual Host konfigurieren ───────────────────────
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html/public\n\
    DirectoryIndex index.php\n\
    <Directory /var/www/html/public>\n\
        AllowOverride All\n\
        Require all granted\n\
        Options -Indexes\n\
    </Directory>\n\
    ErrorLog ${APACHE_LOG_DIR}/error.log\n\
    CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# ── PHP-Konfiguration ────────────────────────────────────────
RUN echo "upload_max_filesize = 20M\n\
post_max_size = 25M\n\
max_execution_time = 120\n\
memory_limit = 256M\n\
display_errors = On\n\
error_reporting = E_ALL\n\
date.timezone = Europe/Berlin" \
> /usr/local/etc/php/conf.d/custom.ini

# ── OPcache ─────────────────────────────────────────────────
RUN echo "opcache.enable=1\n\
opcache.memory_consumption=128\n\
opcache.interned_strings_buffer=8\n\
opcache.max_accelerated_files=10000\n\
opcache.revalidate_freq=0\n\
opcache.validate_timestamps=1" \
> /usr/local/etc/php/conf.d/opcache.ini

# ── Composer installieren ────────────────────────────────────
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# ── Arbeitsverzeichnis ───────────────────────────────────────
WORKDIR /var/www/html

# ── Dateien kopieren ─────────────────────────────────────────
COPY . .

# ── Verzeichnis-Rechte setzen ────────────────────────────────
RUN mkdir -p storage/cache storage/logs storage/sessions storage/uploads/products storage/uploads/documents \
    && chown -R www-data:www-data storage public/assets \
    && chmod -R 775 storage

# ── composer.json erstellen falls nicht vorhanden ───────────
RUN if [ ! -f composer.json ]; then \
    composer init --no-interaction \
        --name="techstore/ecommerce" \
        --description="TechStore E-Commerce" \
        --type="project" \
        --require="php:>=8.2"; \
    fi

# Autoloader generieren
RUN composer dump-autoload --optimize 2>/dev/null || true

EXPOSE 80
