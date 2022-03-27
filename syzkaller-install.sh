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

# TODO Eventually replace this with the appropriate full qemu install
qemu-system-x86_64 --version
if [ $? -ne 0 ]; then
    sudo apt install qemu-system-x86
fi

pushd ${DIR}
sudo git clone https://github.com/N3ar/syzkaller.git

pushd ${DIR}/syzkaller
sudo git remote add upstream https://github.com/google/syzkaller.git
sudo git fetch upstream

make -j8

VER=$(uname -r | awk -F- '{ print $1 }' | awk -F. '{ print $1 }')
if [ ${VER} -le 4 ]; then
    echo "Please check your kernel version, you may need to configure kcov."
    read -s -n 1 -p "Press any key to continue or ctrl+c to exit..."
    echo ""
fi

# TODO Apply optimal configs
echo "RUN THE PYTHON UPDATER"
echo "Improve syzcaller detection capabilities by optimizing the configs"
echo "https://github.com/n3ar/syzkaller/blob/master/docs/linux/kernel_configs.md"

# TODO Direct user to image creation
sudo apt install -y debootstrap make gcc flex bison libncurses-dev libelf-dev libssl-dev 
echo "Gotta get new Kernel & Build"
echo "Get to the correct config for the architecture in question."
read -s -n 1 -p "Press any key to continue..."


popd
popd

exit 0
