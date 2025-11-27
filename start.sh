#!/bin/ash

# echo "Starting PHP-FPM..."
# /usr/sbin/php-fpm7 --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize

# The binaries otherwise mismatch and Ghost will fail to start
npm install sqlite3 --save

echo "Starting Ghost..."
cd ./ghost && ghost start &
./caddy-server run --watch --config ./caddy/Caddyfile