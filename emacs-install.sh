#!/bin/bash

echo "Adding Kevin Kelley's Emacs PPA for Emacs 30..."
sudo add-apt-repository ppa:kelleyk/emacs -y
sudo apt update -y

echo "Determining latest Emacs native-comp package..."
latest_native_comp_pkg=$(
    apt-cache search '^emacs[0-9]+-native-comp$' |
    grep -o '^emacs[0-9]\+-native-comp' |
    sort -Vr |
    head -n1
)

sudo apt install -y "${latest_native_comp_pkg}"
