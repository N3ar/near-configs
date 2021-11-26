#!/bin/bash

OPT=/opt
HOME=/home/$(whoami)
DWN=${HOME}/Downloads
BIN=${HOME}/.local/bin

echo "Installing Ghidra..."
pushd ${DWN}
ls | grep Ghidra
if [[ $? -eq 1 ]]; then
  curl -s https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/latest \
    | grep "browser_download_url" \
    | cut -d '"' -f 4 \
    | wget -qi -
  echo "Ghidra Download complete"
fi

FILE=$(ls | grep Ghidra)
sudo mv ${FILE} ${OPT}

pushd ${OPT}
unzip ${FILE}
rm ${FILE}

echo "Ghidra download complete"
DIR=$(ls | grep ghidra)
sudo ln -s ${OPT}/${DIR}/ghidraRun ${BIN}/ghidra

popd
popd

exit 0
