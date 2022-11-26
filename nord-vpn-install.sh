#!/bin/bash
wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb .
sudo apt install nordvpn-release_1.0.0_all.deb
sudo apt update
rm nordvpn-release_1.0.0_all.deb

