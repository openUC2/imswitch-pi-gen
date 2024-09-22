#!/bin/bash

# Install Daheng Camera Driver

# Create the udev rules directory
mkdir -p /etc/udev/rules.d

mv /usr/lib/python3.11/EXTERNALLY-MANAGED /usr/lib/python3.11/EXTERNALLY-MANAGED.old


# display the architecture
echo "uname -m"
echo $(uname -m)

# Download and install the appropriate Daheng driver based on architecture
cd /tmp
wget -q https://dahengimaging.com/downloads/Galaxy_Linux_Python_2.0.2106.9041.tar_1.gz
wget -q https://dahengimaging.com/downloads/Galaxy_Linux-armhf_Gige-U3_32bits-64bits_1.5.2303.9202.zip
unzip Galaxy_Linux-armhf_Gige-U3_32bits-64bits_1.5.2303.9202.zip
tar -zxvf Galaxy_Linux_Python_2.0.2106.9041.tar_1.gz

# list directory contents
echo "ls -l /tmp/Galaxy_Linux-armhf_Gige-U3_32bits-64bits_1.5.2303.9202"

# Set permissions and install the Galaxy camera driver
cd /tmp/Galaxy_Linux-armhf_Gige-U3_32bits-64bits_1.5.2303.9202
chmod +x Galaxy_camera.run

# Build and install the Python API
cd /tmp/Galaxy_Linux_Python_2.0.2106.9041/api
python3 setup.py build
python3 setup.py install


# Run the installer script using expect to automate Enter key presses
echo "Y En Y" | /tmp/Galaxy_Linux-armhf_Gige-U3_32bits-64bits_1.5.2303.9202/Galaxy_camera.run

# Set the library path
export LD_LIBRARY_PATH="/usr/lib:/tmp/Galaxy_Linux-armhf_Gige-U3_32bits-64bits_1.5.2303.9202:$LD_LIBRARY_PATH"

# Source the bashrc file
#echo "source ~/.bashrc" >> ~/.bashrc
#source ~/.bashrc