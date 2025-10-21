#!/bin/bash

source ./HELPERS.sh
notify i Updating apt repos to avoid broken links
update
upgrade

source ./env.sh
if [[ ${DISTRO} == "ubuntu" ]]; then
    notify i Removing tracking software
    sudo apt purge -y apport
    sudo apt remove -y popularity-contest
    
    notify i You are on Ubuntu, so I am installing Snap to keep it easy.
    sudo apt install snapd -y
elif [[ ${DISTRO} == "pop" ]]; then
    notify Apport crash reporting should be disabled by default on ${DISTRO}
fi

notify i Installing curl
sudo apt install -y curl

notify s Initial config complete.
