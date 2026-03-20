#!/bin/sh
set -e

mkdir -p /var/www/html
if [ ! -f /var/www/html/adminer.php ]; then
  wget -qO /var/www/html/adminer.php https://www.adminer.org/latest.php
fi

echo "[i] Starting Adminer on :80"
exec php -S 0.0.0.0:80 -t /var/www/html
