#!/bin/bash
mkdir gef-gdb
git submodule add https://github.com/hugsy/gef.git gef-gdb/gef
git submodule update --init --recursive
PWD=$(pwd)
touch ~/.gdbinit
echo "source ${PWD}/gef-gdb/gef/gef.py" >> ~/.gdbinit

./capstone-install.sh
./keystone-install.sh
./ropper-install.sh
./unicorn-install.sh
