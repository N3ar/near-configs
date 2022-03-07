#!/bin/bash
DIR=/usr/local

sudo find ${DIR} -type d -name syzkaller > /dev/null
if [ $? -ne 0 ]; then
  exit 1
fi

pushd ${DIR}/syzkaller
sudo git pull upstream master
popd

exit 0

