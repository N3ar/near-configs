#!/bin/bash
sudo apt install -y vim

curl -sLf https://spacevim.org/install.sh | bash

# TODO include the correct colorscheme
cp spacevim-configs/init.toml /home/$(whoami)/.SpaceVim.d/init.toml
