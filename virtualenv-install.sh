#!/bin/bash
which pip3
if [ $? -ne 0 ]; then
    echo "You don't have pip3 installed"
    echo "Please install other python environment components"
    exit 1
fi

pip3 install virtualenv

