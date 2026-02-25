#!/bin/bash

set -eou pipefail

source ./HELPERS.sh
source ./env.sh

if [[ $(is_installed guix) -gt 0 ]]; then
    notify Installing flatpak through APT
    update
    upgrade
    sudo apt install -y flatpak
else
    notify Installing flatpak through GUIX
    guix install flatpak

#    notify Setting up user-only aliases
#    # Ensure Flatpak environment variables are defined in ~/.bash_aliases
#    BASH_ALIASES="$HOME/.bash_aliases"
#
#    # Lines to add
#    read -r -d '' FLATPAK_ENV <<'EOF'
## --- Flatpak environment for user-space installation ---
#export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:/usr/share:$XDG_DATA_DIRS"
#export FLATPAK_SYSTEM_DIR="/var/lib/flatpak"
#export FLATPAK_USER_DIR="$HOME/.local/share/flatpak"
## -------------------------------------------------------
#EOF
#
#    # Append only if not already present
#    if ! grep -q 'FLATPAK_USER_DIR' "$BASH_ALIASES" 2>/dev/null; then
#        echo "$FLATPAK_ENV" >> "$BASH_ALIASES"
#        notify s "Flatpak environment added to ~/.bash_aliases"
#    else
#        notify w "Flatpak environment already defined in ~/.bash_aliases"
#    fi

    flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak update

    if [[ ${DISTRO} == "ubuntu" ]]; then
        sudo tee /etc/apparmor.d/bwrap >/dev/null <<'EOF'
abi <abi/4.0>,
include <tunables/global>

# Allow Bubblewrap to use unprivileged user namespaces
# Cover Debian/Ubuntu bwrap and Guix store paths.
profile bwrap /usr/bin/bwrap flags=(unconfined) {
  userns,
  include if exists <local/bwrap>
}

profile bwrap-guix /gnu/store/*-bubblewrap-*/bin/bwrap flags=(unconfined) {
  userns,
  include if exists <local/bwrap>
}
EOF

        # Reload AppArmor
        sudo apparmor_parser -r /etc/apparmor.d/bwrap || sudo systemctl reload apparmor
    fi
fi

notify s Flatpak installed successfully
