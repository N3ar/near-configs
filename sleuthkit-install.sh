#!/bin/bash

DIR=/usr/local
SRC=${DIR}/sleuthkit

# Install dependencies
g++ --version
if [ $? -ne 0 ]; then
    ./build-install.sh
fi

java --version
if [ $? -ne 0 ]; then
    echo "Go install Java: ./jre-install.sh"
    exit 1
fi

# Update apt since we will be doing some apt installing
sudo apt update

# Clone into source code
pushd ${DIR}
sudo git clone https://github.com/N3ar/sleuthkit

# TODO Fork and mirror libraries that need to be paced
# TODO Additional things needed to install
# http://www.afflib.org
# https://github.com/sshock/AFFLIBv3
sudo git clone https://github.com/sshock/AFFLIBv3
echo "[*] Installing AFFLIBv3 and dependencies"
sudo apt -y install make gcc g++
sudo apt -y install zlib1g-dev libssl-dev libncurses5-dev
sudo apt -y install libcurl4-openssl-dev libexpat1-dev libreadline5-dev
#sudo apt -y install automake1.9 autoconf libtool

pushd AFFLIBv3
./bootstrap.sh
popd #AFFLIBv3

# https://github.com/sleuthkit/libewf_64bit
sudo git clone https://github.com/sleuthkit/libewf_64bit
echo "[*] Installing libewf stable for sleuthkit"
pushd libewf_64bit
./configure
make -j8
make check
make -j8 install
make installcheck

pop #libewf_64bit

# https://github.com/libyal/libvhdi
# TODO Make 1 liner to get latest version of file with a good oneliner
# Probably make github latest fetch 1 lines into a util that I source.
pushd libvhdi
./autogen.sh
popd #libvhdi

# https://github.com/libyal/libvmdk
pushd libvmdk
./autogen.sh
popd #libvmdk

# https://github.com/libyal/libvslvm
pushd libvslv
./autogen.sh
popd #libvslvm

# https://github.com/libyal/libbfio
pushd libbfio
./autogen.sh
popd #libbfio

# TODO Run the actual installation
exit 0
pushd ${SRC}

./configure
make -j8
make -j8 install

popd #SRC

# TODO install autopsy AFTER for GUI
# http://www.sleuthkit.org/autopsy
popd #DIR

exit 0
