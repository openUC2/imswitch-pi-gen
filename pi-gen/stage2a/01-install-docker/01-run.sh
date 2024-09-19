#!/bin/bash -e

# Check if the directory already exists before creating it
if [ ! -d "/etc/docker" ]; then
  mkdir -p /etc/docker
fi

install -m 644 files/daemon.json "${ROOTFS_DIR}/etc/docker/daemon.json"

on_chroot << EOF
usermod -aG docker uc2
dphys-swapfile swapoff
dphys-swapfile uninstall
systemctl disable dphys-swapfile
EOF
