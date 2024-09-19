#!/bin/bash

# PUll the latest user config from GitHub that contain a lot of different hardware configurations for ImSwitch
cd /home/uc2 
git clone https://github.com/openuc2/ImSwitchConfig
cd ImSwitchConfig
git checkout soop # This is the branch that contains the latest user configurations for the flow-stop microscope