#!/usr/bin/env sh

if command -v podman 2>&1 > /dev/null; then
    echo "Download Podman first. Reduce clutter. Come on."
    exit 0
fi

# TODO see if podman pull ghcr.io/open-webui/open-webui is required
podman pull ghcr.io/open-webui/open-webui

# TODO see if 'open-webui' is a container or not
podman run -d --name open-webui \
    --network=host \
    -e OLLAMA_BASE_URL=http://127.0.0.1:11434 \
    -v open-webui:/app/backend/data \
    --restart=always \
    ghcr.io/open-webui/open-webui:main

# TODO run it if it works
podman start open-webui
