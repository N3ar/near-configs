#!/bin/bash
set -euo pipefail

source ./HELPERS.sh
source ./env.sh

notify "Installing signal-desktop messenger application"

if [[ $(is_installed flatpak) -eq 0 ]]; then
    flatpak install --user org.signal.Signal
    notify s "Signal has been installed through flatpak"
    exit 0
fi

if [[ $(is_installed guix) -eq 0 ]]; then
    notify w "Flatpak not present on this machine, installing through guix as fallback"
    notify w "Desktop launcher won't work correctly without disabling sandboxing"
    notify w "I haven't added a permanent way to do this outside of the terminal"
    guix install signal-desktop
    notify s "Signal has been installed through guix"
    exit 0
fi

notify w "Guix not present on this machine, installing apt repo as fallback"
notify i "If install fails, please update with instructions found at:\n\thttps://signal.org/download/linux/"

# 1. Install our official public software signing key:
notify i "Installing official public software signing key"
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

# 2. Add our repository to your list of repositories:
notify i "Adding repo to list of repositories"
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee /etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install Signal:
notify "Updating and upgrading system in advance of install"
update
upgrade
sudo apt install signal-desktop
