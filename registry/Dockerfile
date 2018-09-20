FROM ubuntu:18.04

## label and credits
LABEL image="Dockerized Docker Distribution - Docker Registry Docker Image" \
      maintainer="Roozbeh Shafiee, me@roozbeh.cloud" \
      version="1.0.0-production" \
      released="September 20th, 2018" \
      reference="https://roozbeh.cloud, https://github.com/RoozbehShafiee"

## environment variables
ENV DISTRIBUTION_DIR /go/src/github.com/docker/distribution
ENV DOCKER_BUILDTAGS include_oss include_gcs
ENV GOVERSION 1.10.3
ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH

ARG GOOS=linux
ARG GOARCH=amd64

## manage packages and repositories
RUN apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y install \
                  make \
                  git \
                  wget \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/*

## install golang and docker registry requirements
RUN wget https://dl.google.com/go/go$GOVERSION.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go$GOVERSION.linux-amd64.tar.gz \
    && rm go$GOVERSION.linux-amd64.tar.gz \
    && mkdir -p $DISTRIBUTION_DIR \
    && git clone https://github.com/docker/distribution.git $DISTRIBUTION_DIR \
    && mkdir -p /etc/docker/registry \
    && mv $DISTRIBUTION_DIR/cmd/registry/config-dev.yml /etc/docker/registry/config.yml

## working directory
WORKDIR $DISTRIBUTION_DIR

## compiling docker registry
RUN make PREFIX=/go clean binaries

## defining volumes
VOLUME ["/var/lib/registry"]

## expose ports
EXPOSE 5000

## run service
ENTRYPOINT ["bin/registry"]
CMD ["serve", "/etc/docker/registry/config.yml"]
