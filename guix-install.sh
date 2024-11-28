#!/bin/bash
pushd /tmp

# Fetch most recent guix install script from mirror
wget https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh
chmod +x guix-install.sh
./guix-install.sh

# Update .bashrc with lines left out from install script
cat << EOF > ~/.bashrc
# Automatically added by the Guix install script.
if [ -d "${HOME}/.config/guix" ]; then
    GUIX_PROFILE="${HOME}/.config/guix/current"
    . "$GUIX_PROFILE/etc/profile"
fi
if [ -n "$GUIX_ENVIRONMENT" ]; then
    if [[ $PS1 =~ (.*)"\\$" ]]; then
        PS1="${BASH_REMATCH[1]} [env]\\\$ "
    fi
fi
EOF

popd
