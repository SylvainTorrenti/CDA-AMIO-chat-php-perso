FROM php:8.2-apache
COPY . /var/www/html/
# COPY . /usr/src/myapp
# WORKDIR /usr/src/myapp
RUN apt-get -y update \
&& apt-get install -y libicu-dev \ 
&& docker-php-ext-configure intl \
&& docker-php-ext-install intl
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN chmod -R 755 writable/ 
RUN chown -R www-data:www-data writable/
RUN a2enmod rewrite
WORKDIR /var/www/html/
RUN php spark migrate
# CMD [ "php", "./public/index.php" ]