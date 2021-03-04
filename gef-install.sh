#!/bin/bash
mkdir gef-gdb
pushd gef-gdb;
git clone https://github.com/hugsy/gef.git
PWD=$(pwd)
touch ~/.gdbinit
echo "source ${PWD}/gef/gef.py" >> ~/.gdbinit

./capstone-install.sh
./keystone-install.sh
./ropper-install.sh
./unicorn-install.sh
