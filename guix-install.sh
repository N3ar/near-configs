#!/bin/bash
# TODO Remove HELPERS and ENV, manually define everything in this script so it can be pasted into place

source ./HELPERS.sh
source ./env.sh

if command -v newgidmap > /dev/null 2>&1; then
    notify uidmap installed, proceed.
else
    notify w uidmap must be installed
    if [[ ${DISTRO} == "pop" ]]; then
        sudo apt install uidmap -y
    elif [[ ${DISTRO} == "ubuntu" ]]; then
        sudo apt install uidmap -y
    else
        notify e Please add how to install uidmap here and run again.
        exit 1
    fi
fi

if command -v nscd > /dev/null 2>&1; then
    notify nscd installed, proceed.
else
    notify w nscd must be installed
    if [[ ${DISTRO} == "pop" ]]; then
        sudo apt install nscd -y
    elif [[ ${DISTRO} == "ubuntu" ]]; then
        sudo apt install nscd -y
    else
        notify e Please add how to install nscd here and run again.
        exit 1
    fi
fi

# Fetch most recent guix install script from mirror
pushd /tmp
wget https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh
chmod +x guix-install.sh
sudo ./guix-install.sh
popd

# Copy channels into configuration directories of interest
pushd ${SCRIPT_DIR}/guix-configs
cp channels.scm ${HOME}/.config/guix 
sudo cp channels.scm /etc/guix
popd

# put everything in place
# TODO move such things into near-aliases

#BASH_ALIASES="$HOME/.bash_aliases"
#
## Update .bash_aliases with lines left out from install script
#cat << EOF >> ${BASH_ALIASES}
#
## Automatically added by the Guix install script.
#for GUIX_PROFILE in "$HOME/.config/guix/current" "$HOME/.guix-profile"
#do
#    if [ -f "\${GUIX_PROFILE}/etc/profile" ]; then
#        . "\${GUIX_PROFILE}/etc/profile"
#    fi
#done
#EOF

## Check if already present
#GUARD_COMMENT="# Ensure ~/.guix-profile/bin is in PATH (Guix user profile)"
#if grep -Fxq "$GUARD_COMMENT" "$BASH_ALIASES" 2>/dev/null; then
#    echo "Guix path block already present in $BASH_ALIASES. Skipping."
#else
#    echo "Appending Guix path export block to $BASH_ALIASES..."
#    cat << 'EOF' >> "$BASH_ALIASES"
#
## Ensure ~/.guix-profile/bin is in PATH (Guix user profile)
#if [[ ":$PATH:" != *":$HOME/.guix-profile/bin:"* ]]; then
#    export PATH="$HOME/.guix-profile/bin:$PATH"
#fi
#EOF
#    echo "Done. Guix path block added."
#fi

notify "Updating system guix"
sudo guix pull

notify "Updating user guix"
guix pull

nofity "GUIX UPDATES COMPLETE"
