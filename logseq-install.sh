#!/bin/bash

#TODO THIS SCRIPT IS FOR A SPECIFIC VERSION
DIR=~/.local/bin
SRC=Logseq-linux-x64

TGT=`curl -s https://github.com/logseq/logseq/releases/ \
    | grep AppImage \
    | grep "href=" \
    | cut -d \" -f 2`
URL="https://github.com${TGT}"

APP=`echo ${URL} | cut -d \/ -f 9`
if [ -e ${APP} ]; then
    echo "[*] Logseq appears to already be installed: ${DIR}/${APP}"
    exit 0
fi

pushd ${DIR}
wget ${URL}
chmod +x ${APP}

popd #DIR

exit 0

