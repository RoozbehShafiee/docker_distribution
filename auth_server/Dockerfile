## build build image
FROM golang:alpine AS build

## label and credits
LABEL io.infunity.image.vendor="Infunity Cloud" \
      io.infunity.image.authors="Roozbeh Shafiee" \
      io.infunity.image.title="Docker Authentication Server" \
      io.infunity.image.description="A Docker Image For auth_server Project" \
      io.infunity.image.created="2019-03.09" \
      io.infunity.image.version="0.1-beta" \
      io.infunity.image.licenses="Apache 2.0" \
      io.infunity.image.url="https://infunity.io" \
      io.infunity.image.documentation="https://github.com/RoozbehShafiee/docker_distribution/README.md" \
      io.infunity.image.source="https://github.com/RoozbehShafiee/docker_distribution"

## environment variables
ENV DOCKER_AUTH_DIR /usr/local/go/src/github.com/cesanta/docker_auth

## manage packages and repositories
RUN apk update \
    && apk add --no-cache \
          ca-certificates \
          py2-pip \
          make \
          git \
          wget \
    && pip install gitpython

## pull auth_server project from Github
RUN mkdir -p $DOCKER_AUTH_DIR \
    && git clone https://github.com/cesanta/docker_auth.git $DOCKER_AUTH_DIR

## working directory
WORKDIR $DOCKER_AUTH_DIR/auth_server

## compile docker auth server
RUN make deps \
    && make generate \
    && make

## build final image
FROM alpine:latest

## environment variables
ENV DOCKER_AUTH_DIR /usr/local/go/src/github.com/cesanta/docker_auth

## copy built binary file
COPY --from=build $DOCKER_AUTH_DIR/auth_server/auth_server /usr/local/bin/auth_server

## expose port
EXPOSE 5001

## run service
ENTRYPOINT ["auth_server"]
CMD ["/etc/auth_server/auth.yml"]
