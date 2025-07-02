#!/bin/bash
echo "Updating apt repos to avoid broken links"
sudo apt update -y
sudo apt upgrade -y

DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
if [[ ${DISTRO} == "ubuntu" ]]; then
    echo "You're on Ubuntu, so I am installing Snap to keep it easy."
    sudo apt install snapd -y
    exit 0
fi

sudo apt purge -y apport
sudo apt remove -y popularity-contest

sudo apt install -y curl
