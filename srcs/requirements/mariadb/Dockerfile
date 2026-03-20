#################################################################
# Creates a MariaDB Server image based on Alpine 3.19
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

RUN apk update && \
	apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql && \
	chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/setup.sh"]
