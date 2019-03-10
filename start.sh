#!/bin/bash

echo "Enter the domain address you want to deploy service on (e.g. infunity.cloud):"
read DOMAIN
echo "Enter the email address you want to Let's Encrypt ssl certificates issue for:"
read EMAIL

sed -i "s|email@example.tld|${EMAIL}|g" ./volumes/traefik/traefik.toml
sed -i "s|example.tld|${DOMAIN}|g" ./volumes/traefik/traefik.toml
sed -i "s|example.tld|${DOMAIN}|g" ./docker-compose.yml
sed -i "s|example.tld|${DOMAIN}|g" ./volumes/registry/config.yml

if [ ! -f ./volumes/ssl/certificate.crt ]
then
  openssl genrsa -out ./volumes/ssl/private.key 4096 -nodes
  openssl req -new -x509 -key ./volumes/ssl/private.key -sha256 -config ssl_gen.cnf -out ./volumes/ssl/certificate.crt -days 36500
fi

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v "$PWD:/rootfs/$PWD" -w="/rootfs/$PWD" docker/compose:1.23.2 up -d
echo ""
echo ""
echo "SERVICE DEPLOYED SUCCESSFULLY!"
