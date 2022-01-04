#!/bin/bash
HOME=/home/$(whoami)
sudo apt install -y vim

curl -sLf https://spacevim.org/install.sh | bash

pushd ${HOME}
ls -al | grep ".SpaceVim.d"
if [ $? -ne 0 ]; then
  mkdir .SpaceVim.d
fi
popd

cp spacevim-configs/init.toml ${HOME}/.SpaceVim.d/init.toml
