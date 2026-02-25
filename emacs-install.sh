#!/bin/bash

set -euo pipefail

source ./HELPERS.sh

if [[ $(is_installed guix) -gt 0 ]]; then
    notify w "This system doesn't have guix."
    notify "The lack of guix implies that it is not a primary system"
    notify "Please install neovim and tmux instead"
    notify e "This EMACS install isn't intended for terminal only use"
    exit 1
fi

## Step 1: Ensure Guix is available
## NOTE this is no longer necessary
#if ! command -v guix &> /dev/null; then
    #echo "Guix is not installed. Attempting to install guix."
    #echo "This may take a while....."
    #./guix-install.sh
    #guix pull
#fi

## Step 2: Ensure ~/.guix-profile/bin is in PATH
## NOTE This is now already in nearrc
#GUIX_BIN="$HOME/.guix-profile/bin"
#SHELL_RC="${HOME}/.$(basename "$SHELL")rc"
#
#if ! grep -q "$GUIX_BIN" "$SHELL_RC"; then
#    echo "Adding $GUIX_BIN to PATH in $SHELL_RC"
#    echo -e "\n# Add Guix user profile to PATH\nexport PATH=\"$GUIX_BIN:\$PATH\"" >> "$SHELL_RC"
#fi
#
## Refresh current shell PATH (will persist on next login)
#export PATH="$GUIX_BIN:$PATH"

# Step 3: Install emacs-next via Guix (native-comp included)
echo "Installing emacs via Guix..."
guix install emacs emacs-spacemacs-theme

# Install all fonts and characters
guix install emacs-all-the-icons emacs-spaceline-all-the-icons \
emacs-nerd-icons font-awesome font-google-material-design-icons \
emacs-powerline emacs-spaceline

# Install pandoc for markdown, latex, and other support
guix install pandoc emacs-markdown-mode emacs-pandoc-mode emacs-ox-pandoc

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

## TODO Switch to a near_alias
#echo "alias emacs='emacs > /dev/null 2>&1 & disown'" >> ${HOME}/.bash_aliases

# TODO This path export needs to be in place to support npm things
notify w "INSTALL NPM -- If you want to run bash-ls aka bash-language-server"
cat <<EOF
guix install node
npm config set prefix "$HOME/.npm-global"
export PATH="$HOME/.npm-global/bin:$PATH"
npm install -g bash-language-server
EOF

#echo "Done. Restart your shell or run: source $SHELL_RC"
echo "Done. Restart your shell or run: source .<shell>rc"
echo "Run 'emacs --version' to confirm installation."
