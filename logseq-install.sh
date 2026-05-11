#!/bin/bash
set -euo pipefail

source ./env.sh
source ./HELPERS.sh

install_logseq_sync() {
    notify "Installing Logseq sync services"

    SYNC_DIR="${HOME}/.local/share/logseq-sync"
    SYSTEMD_DIR="${HOME}/.config/systemd/user"
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    mkdir -p "${SYNC_DIR}" "${SYSTEMD_DIR}"

    # Copy scripts and substitute @@HOME@@ with the real path
    for script in logseq-sync-push.sh logseq-sync-pull.sh; do
        cp "${SCRIPT_DIR}/logseq-sync/${script}" "${SYNC_DIR}/${script}"
        chmod +x "${SYNC_DIR}/${script}"
    done

    for unit in logseq-sync-push.service logseq-sync-pull.service \
                logseq-sync-push.timer logseq-sync-pull.timer; do
        sed "s|@@HOME@@|${HOME}|g" \
            "${SCRIPT_DIR}/logseq-sync/${unit}" \
            > "${SYSTEMD_DIR}/${unit}"
    done

    systemctl --user daemon-reload
    systemctl --user enable --now logseq-sync-push.timer
    systemctl --user enable --now logseq-sync-pull.timer
    systemctl --user enable logseq-sync-push.service
    systemctl --user enable logseq-sync-pull.service

    notify "Logseq sync installed:"
    systemctl --user list-timers '*logseq*'
}

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

    install_logseq_sync

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

install_logseq_sync

notify s "Logseq installed via AppImage"
