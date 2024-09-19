: '
This script modifies our udev rules to always automount USB storage, and make
it available to all users. This is required since, by default, only the user
mounting a drive has RW permissions. The OpenFlexure-WS user therefore does not
have write permissions for drives mounted by the Pi users, which is useless.
NOTE: This will (I think) mean that unchecking the setting in the desktop file
browser to automount will now do nothing. For our application though, this is
probably fine.
'
install -v -D -m 644 files/11-media-automount.rules "${ROOTFS_DIR}/etc/udev/rules.d/11-media-automount.rules"
install -v -D -m 644 files/00-custom-mountflags.conf "${ROOTFS_DIR}/etc/systemd/system/systemd-udevd.service.d/00-custom-mountflags.conf"