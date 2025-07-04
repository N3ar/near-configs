#!/bin/bash

# better commands
# Dynamically define fallback 'rg' if ripgrep is not installed
if ! command -v rg >/dev/null 2>&1; then
  alias rg='rgrep -n --color=auto'
fi

alias make-fast="make -j`nproc`"
alias apt-update-all="sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y"
