#!/bin/bash -e

# Pull the Docker image from GitHub Container Registry
echo "Pulling Docker image from GitHub Container Registry"
# docker pull ghcr.io/openuc2/imswitch-noqt-x64:latest
# docker run -it --rm -p 8001:8001 -p 2222:22 -e HEADLESS=1 -e HTTP_PORT=8001 -e CONFIG_FILE=example_virtual_microscope.json -e UPDATE_GIT=0 -e UPDATE_CONFIG=0 --privileged ghcr.io/openuc2/imswitch-noqt-x64:latest