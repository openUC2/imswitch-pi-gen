#!/bin/bash -e

export PATH=$PATH:/usr/bin:/usr/local/bin


#!/bin/bash -e

# Ensure Docker is installed
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# Create a directory for saving the Docker image inside the image
mkdir -p /home/uc2/docker_images

# Download the Docker image and save it as a tar file
echo "Pulling Docker image from GitHub Container Registry"
docker pull ghcr.io/openuc2/imswitch-noqt-x64:latest
docker save -o /home/uc2/docker_images/imswitch-noqt-x64.tar ghcr.io/openuc2/imswitch-noqt-x64:latest
# docker run -it --rm -p 8001:8001 -p 2222:22 -e HEADLESS=1 -e HTTP_PORT=8001 -e CONFIG_FILE=example_virtual_microscope.json -e UPDATE_GIT=0 -e UPDATE_CONFIG=0 --privileged ghcr.io/openuc2/imswitch-noqt-x64:latest

# Set appropriate permissions for the tar file
chmod 644 /home/uc2/docker_images/imswitch-noqt-x64.tar


