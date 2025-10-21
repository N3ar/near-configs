#!/bin/bash

if command -v guix > /dev/null 2>&1; then
    guix install neovim neovim-packer neovim-syntastic python-neovim-remote vim-vlime
else
    sudo apt -y install neovim
fi
