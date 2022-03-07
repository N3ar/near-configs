#!/bin/bash
DIR=/usr/local

go version
if [ $? -ne 0 ]; then
    ./golang-install.sh
fi

g++ --version
if [ $? -ne 0 ]; then
    ./build-install.sh
fi

pushd ${DIR}
sudo git clone https://github.com/N3ar/syzkaller.git

pushd ${DIR}/syzkaller
sudo git remote add upstream https://github.com/google/syzkaller.git
sudo git fetch upstream

make

VER=$(uname -r | awk -F- '{ print $1 }' | awk -F. '{ print $1 }')
if [ ${VER} -le 4 ]; then
    echo "Please check your kernel version, you may need to configure kcov."
    read -s -n 1 -p "Press any key to continue or ctrl+c to exit..."
    echo ""
fi

# TODO Apply optimal configs
echo "Improve syzcaller detection capabilities by optimizing the configs"
echo "https://github.com/n3ar/syzkaller/blob/master/docs/linux/kernel_configs.md"
read -s -n 1 -p "Press any key to continue..."

# TODO Direct user to image creation
echo "Gotta get new Kernel & Build; install debootstrap; Create Image?; Copy syz-manager config"

# TODO Copy syz-manager config

# TODO Expose syz-manager to subnet instead of localhost

popd
popd

exit 0
