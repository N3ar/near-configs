#!/bin/bash
set -euo pipefail

echo "Checking for installed Emacs native-comp package from Kelley's PPA..."

installed_pkg=$(dpkg -l | awk '/^ii/ && $2 ~ /^emacs[0-9]+-native-comp$/ { print $2 }' | sort -Vr | head -n1)
installed_ver=$(echo "$installed_pkg" | grep -o '[0-9]\+')

if [[ -z "$installed_pkg" ]]; then
    echo "No Emacs native-comp version installed via Kelley's PPA."
    exit 1
else
    echo "Currently installed: $installed_pkg"
fi

echo "Checking available Emacs native-comp versions in Kelley's PPA..."
available_pkg=$(
    apt-cache search '^emacs[0-9]+-native-comp$' |
    grep -o '^emacs[0-9]\+-native-comp' |
    sort -Vr |
    head -n1
)
available_ver=$(echo "$available_pkg" | grep -o '[0-9]\+')

if [[ "$available_ver" -gt "$installed_ver" ]]; then
    echo "Newer version available: $available_pkg"
    echo "Upgrading from $installed_pkg to $available_pkg..."

    echo "Removing old version: $installed_pkg"
    sudo apt remove --purge -y "$installed_pkg"

    echo "Installing new version: $available_pkg"
    sudo apt install -y "$available_pkg"

    echo "Emacs successfully upgraded to $available_pkg"
else
    echo "You already have the latest version installed: $installed_pkg"
fi
