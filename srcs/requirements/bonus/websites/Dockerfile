#################################################################
# Creates a NodeJS Server image based on Debian Bookworm
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

FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y --no-install-recommends nodejs npm && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/site
COPY tools/package.json /opt/site/package.json
RUN npm install --omit=dev
COPY tools/server.js /opt/site/server.js
COPY tools/public /opt/site/public

EXPOSE 3000

CMD ["node", "server.js"]
