#!/bin/bash
HOME=/home/$(whoami)
DWN=${HOME}/Downloads

pushd ${DWN}
# Get installer if you don't already have it
ls | grep "pia-linux"
if [ $? -ne 0 ]; then
    # TODO This link doesn't work. Might be a redirect
    wget https://www.privateinternetaccess.com/installer/x/download_installer_linux
fi

FILE=$(ls | grep "pia-linux")
sh ${FILE}

if [ $? -eq 0 ]; then
    rm ${FILE}
    echo "Installation successful"
    popd
    exit 0
fi
echo "Execution of the 'run' script failed."
popd
exit 1
