FROM ubuntu:latest

# ENVIROMENT
ARG USERNAME='user'
ARG USER_PASSWORD='user'
ARG DEFAULT_WORKSPACE='config'

ENV HOME="/config"

# UPDATE / UPGRADE
RUN \
    echo "****  Instal Essentials  *****" && \
    apt update && apt upgrade -y && \
    apt install -y \
    git \
    nano \
    curl \
    sudo \
    ca-certificates \
    bash

# SSH
RUN \
    echo "****  SSH Essentials  *****" && \
    apt install -y openssh-server && \
    mkdir /var/run/sshd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# add local files
COPY .docker/root /

RUN \
    echo "**** Adding user ****" && \
    useradd -U -d $(echo "/${DEFAULT_WORKSPACE}") -s /bin/bash $(echo "${USERNAME}") && \
    echo "${USERNAME}:${USER_PASSWORD}" | chpasswd && \
    adduser $(echo "${USERNAME}") sudo

# Call Builder script
RUN \
    echo "****  RUN Builder Script  *****" && \
    chmod +x /usr/local/bin/builder_script.sh && \
    /usr/local/bin/builder_script.sh

# CLEAN
RUN \
    echo "****  Clean  *****" && \
    apt clean && \
    rm -rf \
    /config/* \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 22