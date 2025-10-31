#!/bin/bash

source ./env.sh

if command -v guix > /dev/null 2>&1; then
    # TODO Uncomment when python-setup is fixed or fix it myself when it is needed
    guix install neovim neovim-packer neovim-syntastic vim-vlime python-pynvim \
    # python-neovim-remote

    git clone https://github.com/NvChad/starter ${HOME}/.config/nvim && nvim
else
    sudo apt -y install neovim
    git clone https://github.com/NvChad/starter ${HOME}/.config/nvim && nvim
fi
