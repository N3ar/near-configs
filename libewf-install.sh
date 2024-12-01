#!/bin/bash

DIR=/usr/local
SRC=${DIR}/libewf_64bit

if [ -e ${SRC} ]; then
    echo "[*] libewf appears to already be installed: ${SRC}"
    exit 0
fi

# https://github.com/sleuthkit/libewf_64bit
pushd ${DIR}

echo "[*] Installing libewf stable for sleuthkit"
sudo git clone https://github.com/sleuthkit/libewf_64bit

pushd ${SRC}
sudo ./configure
sudo make -j8
sudo make check
sudo make -j8 install
sudo make installcheck

popd #SRC
popd #DIR

