#!/bin/bash
# TODO FUCK ALL THIS JUST INSTALL THE DEV PACKAGE FROM APT
# sudo apt install libewf-dev

set -eou pipefail

DIR=/usr/local
SRC=${DIR}/libewf_64bit

if [ -e ${SRC} ]; then
    echo "[*] libewf appears to already be installed: ${SRC}"
    exit 0
fi

sudo apt install libbz2-dev uuid-dev libfuse-dev

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

exit 0
