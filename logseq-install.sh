#!/bin/bash
set -euo pipefail

# Install Location
TGT=/home/$(whoami)/.local/bin
mkdir -p ${TGT}

# Get latest AppImage
URL=$(curl -s https://api.github.com/repos/logseq/logseq/releases/latest | jq -r "(.assets[].browser_download_url | select(. | contains(\"AppImage\")))")

pushd "${TGT}"
# Remove existing to update
CURRENT=`ls | grep "Logseq"`
if [[ -e "${CURRENT}" ]]; then
    rm "${CURRENT}"
fi

# Download new & set executable
wget "${URL}"
chmod +x Logseq-*

IMG=`find ${TGT} -type f -name "Logseq-*"`
ln -sf ${IMG} $(pwd)/logseq

popd #TGT
