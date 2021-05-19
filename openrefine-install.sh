#!/bin/bash
INST=$(pwd)/external-installers
DNLD=~/Downloads
TGTD=/usr/local

# TODO Curling the github API lastest doesn't work for this repo, I don't know
# why. It just means that I can't programatically get the lastest version w/o
# looking into it a little more. For now just going to put a warning.
echo "WARNING: May not be latest version of the OpenRefine tool. Check: "
echo "https://github.com/OpenRefine/OpenRefine/releases/latest"
echo "to confirm."

ls ${DNLD} | grep openrefine
if [ $? -eq 1 ]; then
  pushd ${DNLD}
  wget https://github.com/OpenRefine/OpenRefine/releases/download/3.4.1/openrefine-linux-3.4.1.tar.gz
  popd
fi

ls ${INST} | grep openrefine
if [ $? -eq 1 ]; then
  pushd ${INST}
  mv $(ls ${DNLD}/openrefine*) .
  popd
fi

pushd ${TGTD}
sudo tar xzf $(ls ${INST}/openrefine*)
popd

rm ${INST}/openrefine*

