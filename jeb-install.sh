#!/bin/bash

HOME=/home/$(whoami)
DWN=${HOME}/Downloads
OPT=/opt
TGT=${OPT}/jeb-ce

ZIP="jeb-package.zip"
URL="https://www.pnfsoftware.com/dl?jeb4ce"
pushd ${DWN}
ls | grep ${ZIP}
if [[ $? -eq 1 ]]; then
    wget -O ${ZIP} ${URL}
fi

ls ${OPT} | grep jeb-ce
if [[ $? -eq 1 ]]; then
    sudo mkdir ${TGT}
    sudo unzip ${ZIP} -d ${TGT}
    if [[ $? -ne 0 ]]; then
        echo "Unzipping failed for some reason."
        exit 1
    fi
fi

sudo ln -s ${TGT}/jeb_linux.sh ${HOME}/.local/bin/jeb_ce

rm ${ZIP}
popd # DWN

echo "path+=('${HOME}/.local/bin')" >> $HOME/.zshrc
echo "jeb-ce install complete! Close your terminal and run 'jeb-ce'."
