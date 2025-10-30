#!/bin/bash

if command -v guix > /dev/null 2>&1; then
    # TODO Uncomment when python-setup is fixed or fix it myself when it is needed
    guix install neovim neovim-packer neovim-syntastic vim-vlime python-pynvim \
    # python-neovim-remote 
else
    sudo apt -y install neovim
fi
