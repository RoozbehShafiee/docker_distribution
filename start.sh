#!/bin/bash

echo "Enter the domain address you want to deploy service on (e.g. infunity.cloud):"
read DOMAIN
echo "Enter the email address you want to Let's Encrypt ssl certificates issue for:"
read EMAIL

sed -i "s|example.tld|${DOMAIN}|g" ./conf/auth_server/auth.yml
sed -i "s|example.tld|${DOMAIN}|g" ./docker-compose.yml
sed -i "s|example.tld|${DOMAIN}|g" ./conf/traefik/traefik.toml
sed -i "s|example.tld|${DOMAIN}|g" ./conf/registry/config.yml
sed -i "s|email@example.tld|${EMAIL}|g" ./conf/traefik/traefik.toml


docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v "$PWD:/rootfs/$PWD" -w="/rootfs/$PWD" docker/compose:1.23.2 up -d
echo ""
echo ""
echo "SERVICE DEPLOYED SUCCESSFULLY!"
