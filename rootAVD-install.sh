#!/bin/bash

HOME=/home/$(whoami)
DEST=/opt
LINK=${HOME}/.local/bin
NAME=rootAVD
URL=https://github.com/newbit1/rootAVD.git

ls ${LINK} | grep ${NAME}
if [[ $? -eq 0 ]]; then
    echo "${NAME} already installed"
    exit 0
fi

pushd ${DEST}
sudo git clone ${URL}

pushd ${NAME}
sudo ln -s ${DEST}/${NAME}/rootAVD.sh ${LINK}/${NAME}

popd
popd

pushd ${HOME}
rgrep "path+=" .zshrc | grep ".local"
if [[ $? -eq 1 ]]; then
    echo "path+=('${HOME}/.local/bin')"
fi
popd

exit 0
