#!/bin/bash

source ./HELPERS.sh
source ./env.sh

if [[ $(is_installed guix) -gt 0 ]]; then
    sudo apt install -y net-tools
else
    guix install net-tools
fi
