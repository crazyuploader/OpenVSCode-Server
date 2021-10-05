# OpenVSCode-Server

> Run VS Code in browser! Based on GitPod [OpenVSCode Server](https://github.com/gitpod-io/openvscode-server).

Source code for VS Code Server Docker Image on [DockerHub](https://hub.docker.com/repository/docker/crazyuploader/vscode_server).

## Usage

```bash
docker run --detach --name=vscode_server --publish 127.0.0.1:3000:3000 --restart=unless-stopped crazyuploader/vscode_server
```
