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
sudo apt update -y

# Install dependencies
./afflibv3-install.sh
./libewf-install.sh
./libvhdi-install.sh
./libvmdk-install.sh
#./libvslv-install.sh
#./libbfio-install.sh
sudo ldconfig

# Clone into source code
pushd ${DIR}
sudo git clone https://github.com/N3ar/sleuthkit

# TODO Fork and mirror libraries that need to be paced

# https://github.com/libyal/libvslvm
pushd libvslv
./autogen.sh
popd #libvslvm

# https://github.com/libyal/libbfio
pushd libbfio
./autogen.sh
popd #libbfio

# TODO Run the actual installation
pushd ${SRC}

./configure
make -j8
make -j8 install

popd #SRC

# TODO install autopsy AFTER for GUI
# http://www.sleuthkit.org/autopsy
popd #DIR

exit 0
