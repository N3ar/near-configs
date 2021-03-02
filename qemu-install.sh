#!/bin/bash
sudo apt install ninja-build libglib2.0-dev -y

sudo git clone git://git.qemu.org/qemu.git /opt/qemu
pushd /opt/qemu 

sudo git submodule update --init --recursive

sudo ./configure --static --disable-system --enable-linux-user

sudo make -j8
sudo make install 

# TODO place in /usr/local/bin?

popd

