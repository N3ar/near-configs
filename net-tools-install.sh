#!/bin/bash

source ./HELPERS.sh
source ./ENV.sh

if ! is_installed guix; then
    sudo apt install -y net-tools
else
    guix install net-tools
fi
