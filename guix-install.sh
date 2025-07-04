#!/bin/bash
pushd /tmp

# Fetch most recent guix install script from mirror
wget https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh
chmod +x guix-install.sh
sudo ./guix-install.sh

# Update .bash_aliases with lines left out from install script
cat << EOF >> ~/.bash_aliases

# Automatically added by the Guix install script.
if [ -d "${HOME}/.config/guix" ]; then
    export GUIX_PROFILE="${HOME}/.config/guix/current"
    . "$GUIX_PROFILE/etc/profile"
fi
EOF

popd

BASH_ALIASES="$HOME/.bash_aliases"
GUARD_COMMENT="# Ensure ~/.guix-profile/bin is in PATH (Guix user profile)"

# Check if already present
if grep -Fxq "$GUARD_COMMENT" "$BASH_ALIASES" 2>/dev/null; then
    echo "Guix path block already present in $BASH_ALIASES. Skipping."
else
    echo "Appending Guix path export block to $BASH_ALIASES..."
    cat << 'EOF' >> "$BASH_ALIASES"

# Ensure ~/.guix-profile/bin is in PATH (Guix user profile)
if [[ ":$PATH:" != *":$HOME/.guix-profile/bin:"* ]]; then
    export PATH="$HOME/.guix-profile/bin:$PATH"
fi
EOF
    echo "Done. Guix path block added."
fi
