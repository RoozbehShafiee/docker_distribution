FROM alpine:latest

## label and credits
LABEL io.infunity.image.vendor="Infunity Cloud" \
      io.infunity.image.authors="Roozbeh Shafiee" \
      io.infunity.image.title="Docker Registry Certificate Dumper" \
      io.infunity.image.description="A Docker Image For Dumping ACME JSON SSL Certificates" \
      io.infunity.image.created="2019-03.09" \
      io.infunity.image.version="0.1-beta" \
      io.infunity.image.licenses="Apache 2.0" \
      io.infunity.image.url="https://infunity.io" \
      io.infunity.image.documentation="https://github.com/RoozbehShafiee/docker_distribution/README.md" \
      io.infunity.image.source="https://github.com/RoozbehShafiee/docker_distribution"

## manage packages and repositories
RUN apk update \
    && apk add --no-cache \
           inotify-tools \
           jq \
           openssl \
           util-linux \
           bash

## managing files and directories
ADD dumpcerts.sh /dumpcerts.sh
ADD inotify.sh /inotify.sh
RUN chmod +x /*.sh \
    && bash /dumpcerts.sh /etc/traefik/acme/acme.json /etc/traefik/acme

## Run certdumper service
CMD ["bash", "/inotify.sh"]
