# OpenVSCode-Server

> Run VS Code in browser! Based on GitPod [OpenVSCode Server](https://github.com/gitpod-io/openvscode-server).

[![Docker Image CI](https://github.com/crazyuploader/OpenVSCode-Server/actions/workflows/docker-image.yml/badge.svg)](https://github.com/crazyuploader/OpenVSCode-Server/actions/workflows/docker-image.yml)

Source code for VS Code Server Docker Image on [DockerHub](https://hub.docker.com/repository/docker/crazyuploader/vscode_server).

## Usage

**With Docker Image**

```bash
docker run \
    --detach \
    --name=vscode_server \
    --publish 127.0.0.1:8000:8000 \
    --restart=unless-stopped \
    crazyuploader/vscode_server
```

**With Docker Compose**

```bash
docker-compose up --build --detach
```

This will pull the Docker Image from [`crazyuploader/vscode_server`](https://hub.docker.com/repository/docker/crazyuploader/vscode_server), and publish the port `3000` on the host machine, and the VS Code Server will then be available at `http://localhost:3000`.

### Based on

- [GitPod - Open VS Code Server](https://github.com/gitpod-io/openvscode-server)
