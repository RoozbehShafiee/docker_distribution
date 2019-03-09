#!/bin/bash

while true; do \
  inotifywait -e modify /etc/traefik/acme/acme.json && \
    bash /dumpcerts.sh /etc/traefik/acme/acme.json /etc/traefik/acme
done
