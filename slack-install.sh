#!/bin/bash
set -e

# 'debian' or 'ubuntu'
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
if [[ ${DISTRO} == "ubuntu" ]]; then
    echo "Ubuntu must install via SNAP for some reason"
    sudo snap install slack --classic
    exit 0
fi

# distro subname "bookworm, jammy, focal"
CODENAME=$(lsb_release -cs)

GPGKEY_URL=https://packagecloud.io/slacktechnologies/slack/gpgkey 
KEYNAME=slack-archive-keyring.gpg
KEYPATH=/usr/share/keyrings/
APTREPO_URL="https://packagecloud.io/slacktechnologies/slack/${DISTRO}/ ${CODENAME} main"

# Get GPG Key
curl -fsSL ${GPGKEY_URL} | sudo gpg --dearmour -o ${KEYPATH}${KEYNAME}

# Install from matching repo
echo "deb [signed-by=${KEYPATH}${KEYNAME}] ${APTREPO_URL}" \
  | sudo tee /etc/apt/sources.list.d/slack.list

# Normal apt stuff 
sudo apt update -y
sudo apt install slack-desktop -y
