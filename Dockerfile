#
# Created by Jugal Kishore - 2021
#
# Description: VS Code Server Dockerfile
#
# Base Image: ubuntu:noble
FROM ubuntu:noble

# Setting Non-Interactive Build Time Environment Variable
ARG DEBIAN_FRONTEND=noninteractive

# Setting TERM Environment Variable
ENV TERM=xterm-256color

# VS Code Server Version
ARG VSCODE_VERSION=1.93.1

# Package list update and upgrade
RUN apt-get update && \
    apt-get upgrade --yes

# Installing packages
RUN apt-get install --yes --no-install-recommends \
    apt-transport-https \
    btop \
    ca-certificates \
    curl \
    git \
    gpg \
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

# Remove default user "ubuntu" if it exists
RUN if id "ubuntu" &>/dev/null; then \
    deluser --remove-home --remove-all-files ubuntu; \
    fi

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

ENTRYPOINT ["/opt/openvscode-server/node", "/opt/openvscode-server/out/server-main.js", "--host", "0.0.0.0"]
