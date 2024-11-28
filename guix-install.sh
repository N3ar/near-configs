#!/bin/bash
# TODO ADD THE .BASHRC STUFF THAT I ADDED MANUALLY AFTER THE FACT
pushd /tmp

wget https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh
chmod +x guix-install.sh
./guix-install.sh

popd
