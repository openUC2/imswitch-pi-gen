# Docker image generation from Raspberry Pi OS

This folder will take a previously-built OS image, and create a Docker image based on it. This is useful for testing software on a Raspberry Pi-like environment.

## Why is this helpful?

In order to test our server builds, it's useful to be able to run the server in a good approximation to the deployment environment, i.e. a Raspberry Pi running our customised Raspberry Pi OS. This can be done using `chroot`, `qemu`, and a loop-mounted disk image. However, the loop mount only works in privileged Docker containers, so it won't fly in CI without a lot of tricky (and potentially insecure) configuration.

## Progress so far?

The script `create-docker-image.sh` will mount an image, create a tarball, import that into Docker, and tag the image ready for pushing to our repository. It accepts one argument, the image filename, and prints (but does not execute) the command to push the tag to the repository.

For the commands used, please see the script. Note that it must run as root - otherwise the various mounts and docker commands will fail. I have not found a way around this, and consequently I'm not sure this bit can be included in any CI scripts on gitlab: much safer to run it manually (or periodically) on our own server. I'd suggest it's probably worth running after every OS image build.  It might be nice to tag the images with the corresponding OS image name, as well as "latest".