: '
This script registers an avahi service to broadcast the device as being
an available ImSwitch Microscope. This can be used for discovery of
microscopes connected to the network.
'
install -v -m 644 files/ofm.service "${ROOTFS_DIR}/etc/avahi/services/imswitch.service"
