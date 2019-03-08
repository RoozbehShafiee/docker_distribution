FROM ubuntu:18.04

## label and credits
LABEL image="Dockerized Docker Distribution - Authentication Server Docker Image" \
      maintainer="Roozbeh Shafiee, me@roozbeh.cloud" \
      version="1.0.0-production" \
      released="September 20th, 2018" \
      reference="https://roozbeh.cloud, https://github.com/RoozbehShafiee"

## environment variables
ENV DOCKER_AUTH_DIR /go/src/github.com/cesanta/docker_auth
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
                  ca-certificates \
                  python-pip \
                  make \
                  git \
                  wget \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/* \
    && pip install gitpython

## install golang and authentication server requirements
RUN wget https://dl.google.com/go/go$GOVERSION.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go$GOVERSION.linux-amd64.tar.gz \
    && rm go$GOVERSION.linux-amd64.tar.gz \
    && mkdir -p $DOCKER_AUTH_DIR \
    && git clone https://github.com/cesanta/docker_auth.git $DOCKER_AUTH_DIR

## working directory
WORKDIR $DOCKER_AUTH_DIR/auth_server

## compiling docker registry
RUN make deps \
    && make generate \
    && make

## expose ports
EXPOSE 5001

## run service
ENTRYPOINT ["./auth_server"]
CMD ["/etc/infunity/auth/config.yml"]
