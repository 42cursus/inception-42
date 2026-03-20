#################################################################
# Creates a Redis Server image based on Debian 10
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
# Version:		v0.1.0
#################################################################

FROM debian:buster

RUN apt-get -y update && \
  apt install redis-server -y

RUN echo "maxmemory 256mb" >> /etc/redis/redis.conf && \
    echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf && \
    sed -i -r "s/bind 127.0.0.1/#bind 127.0.0.0/" /etc/redis/redis.conf

CMD ["redis-server",  "--protected-mode", "no"]
