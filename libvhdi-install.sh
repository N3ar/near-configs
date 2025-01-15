#!/bin/bash
set -euo pipefail

#TODO THIS SCRIPT IS GOT A SPECIFIC VERSIOJ
DIR=/usr/local
SRC=${DIR}/libvhdi-20240509

if [ -e ${SRC} ]; then
    echo "[*] libvhdi appears to already be installed: ${SRC}"
    exit 0
fi

# https://github.com/libyal/libvhdi
pushd /tmp
#VHDI=`curl -s https://github.com/libyal/libvhdi/releases \
#    | grep libvhdi-alpha \
#    | grep -m 1 href \
#    | cut -d \" -f 6`
wget https://github.com/libyal/libvhdi/releases/download/20240509/libvhdi-alpha-20240509.tar.gz
sudo tar xvf libvhdi-alpha-20240509.tar.gz -C ${DIR}

pushd ${SRC}
sudo ./synclibs.sh
sudo ./autogen.sh
sudo ./configure
sudo make -j8
sudo sudo make -j8 install

popd #SRC
popd #tmp

exit 0

