#
# Created by Jugal Kishore - 2021
#
# Description: VS Code Server Dockerfile
#
# Using Base Image: ubuntu:focal
FROM ubuntu:focal

# Setting Non-Interactive Build Time Environment Variable
ARG DEBIAN_FRONTEND=noninteractive

# Setting TERM Environment Variable
ENV TERM=xterm-256color

# VS Code Server Version
ARG VSCODE_VERSION=1.60.2

# Package list update and upgrade
RUN apt-get update && \
    apt-get upgrade --yes

# Installing packages
RUN apt-get install --yes \
    apt-transport-https \
    ca-certificates \
    curl \
    git \
    gnupg-agent \
    iputils-ping \
    mtr \
    nano \
    net-tools \
    software-properties-common \
    sudo \
    traceroute \
    vim \
    wget

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Adding user & setting it up
RUN useradd -ms /usr/bin/bash -G sudo -u 1000 jungle && \
    echo "jungle ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    passwd -d jungle

WORKDIR /opt

# Downloading VS Code Server
RUN wget --quiet https://github.com/gitpod-io/openvscode-server/releases/download/openvscode-server-v${VSCODE_VERSION}/openvscode-server-v${VSCODE_VERSION}-linux-x64.tar.gz && \
    tar -xzf openvscode-server-v${VSCODE_VERSION}-linux-x64.tar.gz && \
    rm openvscode-server-v${VSCODE_VERSION}-linux-x64.tar.gz && \
    mv openvscode-server-v${VSCODE_VERSION}-linux-x64 openvscode-server

# Switching User
USER jungle

# Expose port 3000
EXPOSE 3000

ENV HOME=/home/jungle
ENV PATH=${PATH}:/home/jungle/.local/bin

ENTRYPOINT ["/opt/openvscode-server/server.sh"]
