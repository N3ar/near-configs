#!/bin/bash
set -euo pipefail

DIR=/usr/local
SRC=${DIR}/AFFLIBv3

# http://www.afflib.org
if [ -e ${SRC} ]; then
    echo "[-] AFFLIB appears to already be installed: ${SRC}"
    exit 0
fi

echo "[*] Installing AFFLIBv3 and dependencies"
sudo apt update -y && sudo apt upgrade -y
sudo apt -y install make gcc g++
sudo apt -y install zlib1g-dev libssl-dev libncurses5-dev
sudo apt -y install libcurl4-openssl-dev libexpat1-dev libreadline-dev
#sudo apt -y install automake1.9 autoconf libtool

# https://github.com/sshock/AFFLIBv3
pushd ${DIR}
sudo git clone https://github.com/sshock/AFFLIBv3

pushd ${SRC}
sudo ./bootstrap.sh
sudo ./configure
sudo make -j8
sudo make -j8 install

popd #SRC
popd #DIR

exit 0


