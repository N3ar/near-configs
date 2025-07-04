#!/bin/bash
set -euo pipefail

echo "Identifying installed Emacs native-comp version from Kelley's PPA..."
installed_pkg=$(dpkg -l | awk '/^ii/ && $2 ~ /^emacs[0-9]+-native-comp$/ { print $2 }' | sort -Vr | head -n1)

if [[ -z "$installed_pkg" ]]; then
    echo "No Emacs native-comp version from Kelley's PPA found. Exiting."
    exit 0
fi

echo "Found: $installed_pkg — removing..."
sudo apt remove --purge -y "$installed_pkg"

echo "Optionally removing PPA: ppa:kelleyk/emacs"
read -p "Do you want to remove the Kelley's PPA as well? (y/N): " confirm
if [[ "$confirm" == [yY] ]]; then
    sudo add-apt-repository --remove -y ppa:kelleyk/emacs
    sudo apt update -y
    sudo apt autoremove -y
fi

echo "Emacs from Kelley's PPA has been removed."
