#!/bin/bash
echo "Installing linux kernel headers for Kernel development."
if [ -d /lib/modules/$(uname -r)/build ]; then
  echo "Kernel development capabilities already installed."
  return 0
fi

sudo apt install linux-headers-$(uname -r)
if [ ! -d /lib/modules/$(uname -r)/build ]; then
  echo "Kernel development capabilities not installed."
  return 1
fi

echo "SUCCESS! Kernel development capabilities installed!"
return 0

