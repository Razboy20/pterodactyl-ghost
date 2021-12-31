#!/bin/ash

cd /mnt/server

apk --no-cache add curl sudo nodejs npm
apk add --no-cache 'su-exec>=0.2'
npm install ghost-cli@latest -g

cp -r ./temp/caddy /mnt/server/
cp ./temp/start.sh /mnt/server
curl "https://caddyserver.com/api/download?os=linux&arch=amd64&idempotency=33572405766393" -s --output /mnt/server/caddy-server

chmod +x /mnt/server/caddy-server
chmod +x /mnt/server/start.sh

mkdir /mnt/server/ghost
mkdir /mnt/server/.ghost
# route ghost config location to mount
ln -s /mnt/server/.ghost /.ghost
chown -R nobody: /mnt/server/
chmod -R u+w /mnt/server/
# route yarn install location
mkdir -p /.cache/yarn
chown -R nobody: /.cache/yarn/
chmod -R u+w /.cache/yarn/
su -s /bin/ash "nobody" -c "ghost install local --no-start --no-enable --no-prompt --dir /mnt/server/ghost --process local"
unlink /.ghost

ghostlink=$(readlink /mnt/server/ghost/current)
ln -sfn /home/container/${ghostlink:12} /mnt/server/ghost/current