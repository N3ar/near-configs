#!/bin/bash

# better commands
alias apt-update-all="sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y"
alias rg="rgrep -n --color=auto "
alias make="make -j$((`nproc`/2))"
alias logseq="$(find ~/.local/bin/ -type f -name "Logseq*") > /dev/null 2>&1 & disown"

which autopsy
if [[ $? -eq 0 ]]; then
    alias autopsy="autopsy --nosplash"
fi

