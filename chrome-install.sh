#!/bin/bash
set -e

# Set up a temporary workspace
INST=$(pwd)/external-installers
mkdir -p "${INST}"

# Google's repo config
GPG_KEY_URL=https://dl.google.com/linux/linux_signing_key.pub
GPG_KEYRING=/usr/share/keyrings/google-chrome.gpg
REPO_FILE=/etc/apt/sources.list.d/google-chrome.list

# Enter installer workspace
pushd "${INST}"

# Download and install the GPG key
wget -q -O - "${GPG_KEY_URL}" | sudo gpg --dearmor -o "${GPG_KEYRING}"

# Set up the repository
echo "deb [arch=amd64 signed-by=${GPG_KEYRING}] http://dl.google.com/linux/chrome/deb/ stable main" | \
  sudo tee "${REPO_FILE}"

# Update package list and install Chrome
sudo apt update
sudo apt install -y google-chrome-stable

# Cleanup workspace (optional)
popd
