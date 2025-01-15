#!/bin/bash

# better commands
alias rg="rgrep -n --color=auto "
alias make="make -j`nproc/2`"

alias apt-update-all="sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y"

which autopsy
if [[ $? -eq 0 ]]; then
    alias autopsy="autopsy --nosplash"
fi

