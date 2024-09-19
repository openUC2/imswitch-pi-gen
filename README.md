# Openflexure Pi OS

This repository is intended to become the new home for the OpenFlexure OS image (currently generated in the `openflexure/pi-gen` repository).  It will include `pi-gen` from upstream (i.e. the Raspberry Pi project) as a submodule, in order to better separate the OpenFlexure-specific modifications from the upstream project.

## pull submodules 

``` 
git submodule update --init --recursive
cd pi-gen
git checkout 2024-07-04-raspios-bookworm-arm64
chmod +x patch_pi_gen.sh
./patch_pi_gen.sh
cd pi-gen 
./build-docker.sh
```

## Building

Building the OS takes a while! There are a few basic steps:

* Clone the project including the `pi-gen` submodule. See below for explanation - the command `git clone --recurse-submodules https://gitlab.com/openflexure/openflexure-pi-os.git` should work.
* Add in the OpenFlexure-specific configuration and install steps by running `./patch_pi_gen.sh`.
* Build the image, usually with `cd pi-gen` then `./build-docker.sh`.

You may want to familiarise yourself with the upstream [pi-gen] which has a pretty good README. 

### Git submodules

To clone the repository includin `pi-gen`, you will need to [enable submodules], which is as simple as adding `--recurse-submodules` to your clone command. It can also be done after the fact, if you see the link to [enable submodules]. To clone with submodules, use:

```
git clone --recurse-submodules https://gitlab.com/openflexure/openflexure-pi-os.git
```

This will clone all the files in this repository, plus the whole `pi-gen` repository, and ensures that you have the right version of `pi-gen` (it references a specific commit).

### OpenFlexure-specific install steps

We add in two "stages" to the 'pi-gen' build process, to install the OpenFlexure software.  Stage 2a runs after we've built a "Raspberry Pi OS Lite" image (i.e. no graphical interface) and includes the server and command-line clients. Stage 4a runs after we have a full graphical desktop version of Raspberry Pi OS, and installs the OpenFlexure desktop image and OpenFlexure Connect graphical client.

Each "stage" is a folder with a number of steps in it, which are run in sequence.  Each step contains three types of file, which are also read in alphabetical order:

* `-packages` files specify a list of packages to install usin `apt`
* `-run-chroot.sh` files are shell scripts that get run inside the `chroot`, i.e. they are effectively run on the operating system that we are building.  Cunning emulation means that we can run `armhf` binary code, so it really is more or less equivalent to working on a Raspberry Pi.
* `-run.sh` files are shell scripts that get run on the build system, and can download and install files.

See the "How the build process works" section of pi-gen's readme for more details.

### Notes for running pi-gen

If running on linux, `qcow2` is a high-performance way to improve disk usage and build speed, and it's worth enabling. This probably won't work if you are building on WSL. It's on by default in our configuration. 

The OS build process needs internet access. It won't use the system's HTTP_PROXY variable and may need a manual edit to `config` in order to include this.  I have added a step to `patch_pi_gen.sh` that copies the system's `HTTP_PROXY` variable into `config` in order to make it work on systems that use `HTTP_PROXY` but don't have internet access otherwise. If you don't have a proxy set, it will omit that line and should still work - but I've only tested on a system with a proxy set.

If you are frequently re-running to tweak things, it's worth following the steps from the pi-gen readme.  After a failed build, you can `touch stage0/SKIP` for each stage that built OK, and then run (from the `pi-gen` directory):

```
../patch_pi_gen.sh && sudo CONTINUE=1 CLEAN=1 ./build-docker.sh
```

This will skip the previous stages and just re-do the ones that failed. I think you can only skip stages at the start, i.e. you can't rebuild 3a and 4a but not 4.


[pi-gen]: https://github.com/RPi-Distro/pi-gen
[enable submodules]: https://git-scm.com/book/en/v2/Git-Tools-Submodules#_cloning_submodules
