#!/bin/bash
set -euo pipefail

# TODO THERE APPEAR TO BE PREREQUISITE INSTALL SCRIPTS FOR SLEUTHKIT AND AUTOPSY
# They are part of an autopsy release, it appears.
# It seems... a lot of the below work is not required.
# afflib, lebewf, libvhdi, libvmdk at least are all accounted for.
# THE QUESTION REMAINS... can I just use the underlying?

CFGDIR=$(dirname "$(realpath "$0")")
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
sudo apt update -y && sudo apt upgrade -y

pushd /tmp
wget -qO- https://api.github.com/repos/sleuthkit/sleuthkit/releases/latest | \
    jq -r '.assets[] | select(.name | endswith(".tar.gz")) | .browser_download_url'

# TODO HAD TO MANUALLY COPY IN tsk_lvm.hpp
# THIS INSTALL IS ROUGH BECAUSE THEY HAVE A BAD TARBALL

# Install dependencies
pushd $CFGDIR
./afflibv3-install.sh
./libewf-install.sh
./libvhdi-install.sh
./libvmdk-install.sh
./libvslvm-install.sh
./libbfio-install.sh
popd 

sudo ldconfig

## Clone into source code
#pushd ${DIR}
#sudo git clone https://github.com/sleuthkit/sleuthkit.git
#
#pushd ${SRC}
#sudo ./bootstrap
#sudo make -j8
#sudo make -j8 install
#
#popd #SRC
#popd #DIR
#
# TODO install autopsy AFTER for GUI
# http://www.sleuthkit.org/autopsy
pushd /tmp

# TODO The SNAP really doesn't work. We are going to want the ZIP instead
wget https://github.com/sleuthkit/autopsy/releases/download/autopsy-4.21.0/autopsy_4.21.0_amd64.snap
sudo snap install --dangerous `ls autopsy_*`
sudo snap connections autopsy | sed -nE 's/^[^ ]* *([^ ]*) *- *- *$/\1/p' | xargs -I{} sudo snap connect {}

# TODO add in gtk-cranberra stuff
sudo apt install libcanberra-gtk-module libcanberra-gtk3-module

# TODO Refine the correct method, but probably do it in guix or something. This is terrible
wget https://github.com/sleuthkit/autopsy/releases/download/autopsy-4.21.0/autopsy-4.21.0.zip
unzip autopsy-*
# TODO Run the install scripts in the autopsy thing
# TODO Sort out install location and create symlink for the application

# TODO create bash alias that makes
# autopsy --run--> autopsy --nosplash
# per an error in the github, it needs to run without the splash to avoid hanging

popd

exit 0
