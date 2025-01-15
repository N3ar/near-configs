#!/bin/bash
set -euo pipefail

DIR=/usr/local
SRC=${DIR}/libbfio-20240414

if [ -e ${SRC} ]; then
    echo "[*] libbfio appears to already be installed: ${SRC}"
    exit 0
fi

sudo apt install -y git autoconf automake autopoint libtool pkg-config

# https://github.com/libyal/libbfio
pushd /tmp
wget https://github.com/libyal/libbfio/releases/download/20240414/libbfio-alpha-20240414.tar.gz
sudo tar xvf libbfio-alpha-20240414.tar.gz -C ${DIR}

pushd ${SRC}
#sudo ./synclibs.sh
#sudo ./autogen.sh
sudo ./configure
sudo make -j8
sudo make -j8 install

popd #SRC
popd #tmp

exit 0

