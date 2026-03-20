#################################################################
# Creates a Cadvisor Server image based on Debian Bookworm
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
    apt-get install -y --no-install-recommends wget ca-certificates && \
    wget -O /usr/local/bin/cadvisor https://github.com/google/cadvisor/releases/download/v0.49.1/cadvisor-v0.49.1-linux-amd64 && \
    chmod +x /usr/local/bin/cadvisor && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8080

CMD ["/usr/local/bin/cadvisor"]
