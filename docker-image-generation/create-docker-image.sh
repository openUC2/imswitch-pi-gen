#!/bin/bash

root_fs=/mnt/pi/rootfs
image_file="$1"
image_tag="registry.gitlab.com/openflexure/openflexure-pi-os/openflexure-pi-os:latest"

if [ ! -f "$image_file" ]; then
    echo "Image file specified ($image_file) does not exist. Exiting. Image filename should be the only argument."
    exit -1
fi

set -e # Stop on errors

# Mount the image
mkdir -p "$root_fs"

# Abort if something is already mounted there
if mountpoint "$root_fs" > /dev/null; then
    echo "Something is already mounted at $root_fs"
    exit -1
fi

# Create a loop device for our file and mount it
kpartx -a "$image_file"
kpartx_output=$(kpartx -l "$image_file")
loopdev="/dev/mapper/${kpartx_output%%p1 *}" # Discard all output after "p1 " to get the device root
if [ -e "${loopdev}p2" ]; then
    echo "Created a loop device at ${loopdev}p2"
else
    echo "Something went wrong creating the loop device, exiting."
    exit -1
fi
clean_up () { # Make sure we clean up the loop device and associated mounts
    ARG=$?
    echo "Removing loopback device and mounts"
    if mountpoint "$root_fs/boot" > /dev/null; then
        umount "$root_fs/boot"
    fi
    if mountpoint "$root_fs" > /dev/null; then
        umount "$root_fs"
    fi
    kpartx -d "$image_file"
    exit $ARG
} 
trap clean_up EXIT
mount -t ext4 -o ro "${loopdev}p2" "$root_fs"
mount -t vfat -o ro "${loopdev}p1" "$root_fs/boot"

# Make a tar archive, and import this into Docker.
# NB the --exclude to avoid errors relating to ld.so.preload
id=$(tar --numeric-owner -C $root_fs --exclude etc/ld.so.preload -c . | docker import --platform=linux/arm/v6 - openflexure-raspberry-pi-os)


echo "Created image with ID $id"
docker tag "$id" "$image_tag"
echo "Tagged as $image_tag, upload with:"
echo "    sudo docker push $image_tag"
