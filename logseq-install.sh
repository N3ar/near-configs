#!/bin/bash
set -euo pipefail

source ./env.sh
source ./HELPERS.sh

if [[ $(is_installed flatpak) -eq 0 ]]; then
    notify "Prioritizing flatpak installation"
    flatpak install --user flathub com.logseq.Logseq
    flatpak update

    notify "Flatpak generally doesn't have filesystem access"
    notify "Granting access to near's external notes location as of 20251030"
    notify w "Granting access to $HOME/Documents/notes"
    flatpak override --user com.logseq.Logseq --filesystem=$HOME/Documents/notes

    notify "New accesses:"
    flatpak info --show-permissions com.logseq.Logseq

    notify s "Logseq installed via Flatpak"
    exit 0
fi

notify "Flatpak not found, installing via AppImage"

# Install Location
TGT=${HOME}/.local/bin
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
