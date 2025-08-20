#!/bin/bash

# NOTE Old install
#mkdir gef-gdb
#git submodule add -f https://github.com/hugsy/gef.git gef-gdb/gef
#git submodule update --init --recursive
#PWD=$(pwd)
#touch ~/.gdbinit
#echo "source ${PWD}/gef-gdb/gef/gef.py" >> ~/.gdbinit

# New Install from Github
bash -c "$(curl -fsSL https://gef.blah.cat/sh)"

./capstone-install.sh
./keystone-install.sh
./ropper-install.sh
./unicorn-install.sh
