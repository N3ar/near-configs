#!/bin/bash
DIR=/usr/local

sudo find ${DIR} -type d -name sherlock > /dev/null
if [ $? -ne 0 ]; then
  exit 1
fi

pushd ${DIR}/sherlock
sudo git pull upstream master
popd

exit 0






