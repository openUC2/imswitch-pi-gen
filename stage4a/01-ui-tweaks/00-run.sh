#!/bin/bash -e

# Install wallpaper directory
WALLPAPER_ROOT="/usr/share/uc2-wallpaper"
WALLPAPER_ROOT_HOST="${ROOTFS_DIR}${WALLPAPER_ROOT}"
install -d "${WALLPAPER_ROOT_HOST}"

# Install default wallpaper
WALLPAPER_PATH="${WALLPAPER_ROOT}/uc2_4k.png"
WALLPAPER_PATH_HOST="${WALLPAPER_ROOT_HOST}/uc2_4k.png"
install -v -m 644 files/uc2_4k.png "${WALLPAPER_PATH_HOST}"

# Set default wallpaper
TARGET_KEY="wallpaper"
CONFIG_FILE_0="${ROOTFS_DIR}/etc/xdg/pcmanfm/LXDE-pi/desktop-items-0.conf"
CONFIG_FILE_1="${ROOTFS_DIR}/etc/xdg/pcmanfm/LXDE-pi/desktop-items-1.conf"
sed -i "/${TARGET_KEY}=/ s|=.*|=${WALLPAPER_PATH}|" "$CONFIG_FILE_0"
sed -i "/${TARGET_KEY}=/ s|=.*|=${WALLPAPER_PATH}|" "$CONFIG_FILE_1"