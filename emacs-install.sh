#!/bin/bash

set -euo pipefail

# Step 1: Ensure Guix is available
if ! command -v guix &> /dev/null; then
    echo "Guix is not installed. Attempting to install guix."
    echo "This may take a while....."
    ./guix-install.sh
    guix pull
fi

# Step 2: Ensure ~/.guix-profile/bin is in PATH
GUIX_BIN="$HOME/.guix-profile/bin"
SHELL_RC="${HOME}/.$(basename "$SHELL")rc"

if ! grep -q "$GUIX_BIN" "$SHELL_RC"; then
    echo "Adding $GUIX_BIN to PATH in $SHELL_RC"
    echo -e "\n# Add Guix user profile to PATH\nexport PATH=\"$GUIX_BIN:\$PATH\"" >> "$SHELL_RC"
fi

# Refresh current shell PATH (will persist on next login)
export PATH="$GUIX_BIN:$PATH"

# Step 3: Install emacs-next via Guix (native-comp included)
echo "Installing emacs-next via Guix..."
guix install emacs-next

# Step 4: Create an optional symlink for convenience
TARGET_BIN="$HOME/.guix-profile/bin/emacs"
LINK_BIN="$HOME/.local/bin/emacs"

mkdir -p "$(dirname "$LINK_BIN")"
if [[ ! -e "$LINK_BIN" ]]; then
    ln -s "$TARGET_BIN" "$LINK_BIN"
    echo "Created symlink: $LINK_BIN → $TARGET_BIN"
else
    echo "Symlink $LINK_BIN already exists."
fi

echo "Done. Restart your shell or run: source $SHELL_RC"
echo "Run 'emacs --version' to confirm installation."
