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

# Clone into source code
pushd ${DIR}
sudo git clone https://github.com/N3ar/sleuthkit


# TODO Additional things needed to install
# http://www.sleuthkit.org/autopsy

# http://www.afflib.org

# https://github.com/sleuthkit/libewf_64bit

# https://github.com/libyal/libvhdi

# https://github.com/libyal/libvmdk

# https://github.com/libyal/libvslvm
# https://github.com/libyal/libbfio

# TODO Run the actual installation
exit 0
pushd ${SRC}

./configure
make -j8
make -j8 install

popd #SRC

popd #DIR

exit 0
