#!/bin/bash
INST=$(pwd)/external-installers
FILE=google-chrome-stable_current_amd64.deb

pushd ${INST}
if [ ! -f ${FILE} ]; then
  wget https://dl.google.com/linux/direct/${FILE}
fi

sudo apt install ./${FILE}

rm ${FILE}
popd
