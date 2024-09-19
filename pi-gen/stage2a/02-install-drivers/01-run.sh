#!/bin/bash
apt-get update
apt-get install unzip python python3-pip python3-setuptools python3-dev -y
pip3 install numpy pillow

# Install Hikvision Camera Driver
cd /tmp 
wget -q https://www.hikrobotics.com/cn2/source/support/software/MVS_STD_GML_V2.1.2_231116.zip 
unzip MVS_STD_GML_V2.1.2_231116.zip 
echo "Install Hik Driver"
dpkg -i MVS-2.1.2_aarch64_20231116.deb
cd /opt/MVS/Samples/aarch64/Python/
cp GrabImage/GrabImage.py MvImport/GrabImage.py # Copy the GrabImage.py file to the MvImport folder in order to test if it works eventually
export MVCAM_COMMON_RUNENV=/opt/MVS/lib 
export LD_LIBRARY_PATH=/opt/MVS/lib/64:/opt/MVS/lib/32:$LD_LIBRARY_PATH 