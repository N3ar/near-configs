#!/bin/bash
which pip
if [ $? -eq 0 ]; then
  pip install matplotlib
  exit 0
fi

which pip3
if [ $? -eq 0 ]; then
  pip3 install matplotlib
  exit 0
fi

echo "Installer pip not installed. Install pip then try again."
