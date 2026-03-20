#################################################################
# Creates a Adminer Server image based on Debian Bookworm
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
    apt-get install -y --no-install-recommends php-cli php-mysql wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY tools/run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

EXPOSE 80

CMD ["/usr/local/bin/run.sh"]
