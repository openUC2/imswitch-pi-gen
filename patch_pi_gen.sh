#!/bin/bash
# 
# ImSwitchxure OS Build Script Build Script
# 
# The ImSwitchxure SD card image is built using the really helpful pi-gen utility, which
# is included in this repository as a git submodule.  Previously, we forked pi-gen and
# added to it in order to include the ImSwitchxure-specific configuration changes and 
# software. However, this became difficult to manage, as it wasn't clear which changes
# were coming from upstream and which were new. The repository's README was also an
# unhelpful mish-mash of ImSwitchxure-specific things and upstream instructions.
# 
# This script will modify the pi-gen script to include two extra build stages (for the
# ImSwitchxure server and client software) and add some configuration. This can be run
# repeatedly without ill-effects. The build stages are copied (rather than linked) into
# the pi-gen folder, because they are subsequently copied into the Docker instance.
# This is all based on https://gitlab.com/openflexure/openflexure-pi-os/-/tree/main?ref_type=heads

set -e # Set errexit, i.e. exit on failure of any one line.

# Make operation not depend on cwd, but on the script location
# This means it can be run either from the repo root, or from
# the pi-gen/ subfolder.
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $HERE/pi-gen

# For simplicity, copy the two extra stages into this folder
# Symlinks don't work with Docker, unfortunately
rm -rf stage2a stage4a
cp -r ../stage2a stage2a
cp -r ../stage4a stage4a

# We now want to export after 2a and 4a, not after 2 and 4:
rm -f stage2/EXPORT_*
rm -f stage4/EXPORT_*
touch stage2a/EXPORT_IMAGE
touch stage4a/EXPORT_IMAGE

# Copy in our config file (probably simpler than remembering the 
# relevant command line argument each time we build)
rm -f config
cp ../config config

# If a proxy is in use, add this to the config file, so
# that it gets used when building the image. The usual
# environment variables are otherwise ignored.
if [[ $HTTP_PROXY ]]; then
echo "APT_PROXY=$HTTP_PROXY" >> config
fi
