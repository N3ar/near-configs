#!/bin/bash
set -euo pipefail

DIR=/usr/local
SRC=${DIR}/libvslvm-20240504

if [ -e ${SRC} ]; then
    echo "[*] libvslvm appears to already be installed: ${SRC}"
    exit 0
fi

sudo apt install -y git autoconf automake autopoint libtool pkg-config

# https://github.com/libyal/libvslvm
pushd /tmp
wget https://github.com/libyal/libvslvm/releases/download/20240504/libvslvm-experimental-20240504.tar.gz

sudo tar xvf libvslvm-experimental-20240504.tar.gz -C ${DIR}

pushd ${SRC}
#sudo ./synclibs.sh
#sudo ./autogen.sh
sudo ./configure
sudo make -j8
sudo make -j8 install

popd #SRC
popd #tmp

exit 0

