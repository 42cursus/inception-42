#################################################################
# Creates a Nginx Server image based on Alpine 3.19
#                    ##        .
#              ## ## ##       ==
#           ## ## ## ##      ===
#       /""""""""""""""""\___/ ===
#  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
#       \______ o          __/
#         \    \        __/
#          \____\______/
# Author:		abelov <abelov@student.42london.com>
# Contributor:	abelov <abelov@student.42london.com>
# License:
# Version:		v0.1.8
#################################################################

FROM alpine:3.19

RUN apk update && apk add htop iftop iproute2 procps bash vim wget curl

COPY conf/.bash_profile /root/.bash_profile
COPY conf/.bashrc /root/.bashrc

RUN apk update && apk upgrade && apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-json \
    php82-curl \
    php82-dom \
    php82-exif \
    php82-fileinfo \
    php82-mbstring \
    php82-openssl \
    php82-xml \
    php82-zip \
    php82-phar \
    php82-tokenizer \
    wget \
    unzip \
    mariadb-client

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /root/wp-cli.phar
COPY tools/run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh && \
  mv /root/wp-cli.phar /usr/local/bin/wp && \
  chmod +x /usr/local/bin/wp

# Configure PHP-FPM to listen on port 9000
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php82/php-fpm.d/www.conf

# Increase memory limit for WP-CLI
RUN sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php82/php.ini && \
  ln -sf /usr/bin/php82 /usr/bin/php

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/run.sh"]
