#!/bin/bash
set -euo pipefail

#TODO THIS SCRIPT IS FOR A SPECIFIC VERSION
DIR=/usr/local
SRC=${DIR}/libvmdk-20240510

if [ -e ${SRC} ]; then
    echo "[*] libvmdk appears to already be installed: ${SRC}"
    exit 0
fi

# https://github.com/libyal/libvmdk
pushd /tmp
#VHDI=`curl -s https://github.com/libyal/libvhdi/releases \
#    | grep libvhdi-alpha \
#    | grep -m 1 href \
#    | cut -d \" -f 6`
wget https://github.com/libyal/libvmdk/releases/download/20240510/libvmdk-alpha-20240510.tar.gz
sudo tar xvf libvmdk-alpha-20240510.tar.gz -C ${DIR}

pushd ${SRC}
sudo ./synclibs.sh
sudo ./autogen.sh
sudo ./configure
sudo make -j8
sudo make -j8 install

popd #SRC
popd #tmp

exit 0

