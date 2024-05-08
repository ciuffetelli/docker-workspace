FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy

# set version label
ARG BUILD_DATE
ARG VERSION
ARG CODE_RELEASE
ARG ROOT="../.docker/root"

LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config"

RUN \
  echo "****  Instal Essentials  *****" && \
  apt-get update && \
  apt-get install -y \
  git \
  jq \
  libatomic1 \
  nano \
  net-tools \
  netcat \
  sudo

RUN \
  echo "**** Install code-server ****" && \
  if [ -z ${CODE_RELEASE+x} ]; then \
  CODE_RELEASE=$(curl -sX GET https://api.github.com/repos/coder/code-server/releases/latest \
  | awk '/tag_name/{print $4;exit}' FS='[""]' | sed 's|^v||'); \
  fi && \
  mkdir -p /app/code-server && \
  curl -o \
  /tmp/code-server.tar.gz -L \
  "https://github.com/coder/code-server/releases/download/v${CODE_RELEASE}/code-server-${CODE_RELEASE}-linux-amd64.tar.gz" && \
  tar xf /tmp/code-server.tar.gz -C \
  /app/code-server --strip-components=1

# add local files
COPY ${ROOT} /

# Call Builder script
RUN \
  echo "****  RUN Builder Script  *****" && \
  chmod +x /usr/local/bin/builder_script.sh && \
  /usr/local/bin/builder_script.sh

RUN \
  echo "**** clean up ****" && \
  apt-get clean && \
  rm -rf \
  /config/* \
  /tmp/* \
  /var/lib/apt/lists/* \
  /var/tmp/*

# ports and volumes
EXPOSE 8443
