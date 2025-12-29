#!/bin/bash

pushd /tmp
sh <(wget -qO - https://downloads.nordcdn.com/apps/linux/install.sh) -p nordvpn-gui
popd

exit 0

# NOTE Former install
pushd /tmp
wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
sudo apt install ./nordvpn-release_1.0.0_all.deb
sudo apt update -y
sudo apt upgrade -y
rm nordvpn-release_1.0.0_all.deb

popd

sudo apt install nordvpn
