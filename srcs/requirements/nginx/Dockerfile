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

RUN apk update && apk add --no-cache nginx openssl curl ca-certificates

RUN openssl req -x509 -nodes \
  -out /etc/ssl/abelov.42.fr.crt \
  -keyout /etc/ssl/private/abelov.42.fr.key \
  -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=abelov.42.fr/UID=abelov"

COPY conf/server.conf /etc/nginx/http.d/default.conf

RUN mkdir -p /var/run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
