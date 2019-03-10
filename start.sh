#!/bin/bash

echo "Enter the domain address you want to deploy service on (e.g. infunity.cloud):"
read DOMAIN
echo "Enter the email address you want to Let's Encrypt ssl certificates issue for:"
read EMAIL
sed -i "s|email@example.tld|${EMAIL}|g" ./docker-compose.yml
sed -i "s|example.tld|${DOMAIN}|g" ./docker-compose.yml
sed -i "s|example.tld|${DOMAIN}|g" ./registry/config.yml
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v "$PWD:/rootfs/$PWD" -w="/rootfs/$PWD" docker/compose:1.23.2 up -d
echo ""
echo ""
echo "SERVICE DEPLOYED SUCCESSFULLY!"
