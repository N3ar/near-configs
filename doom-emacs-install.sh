#!/bin/bash

set -e

echo "Updating package list..."
sudo apt update -y

echo "Installing Doom Emacs Prereqs per Github Install Instructions..."
sudo apt install -y git ripgrep findutils fd-find

if ! command -v emacs >/dev/null 2>&1; then
  echo "Base emacs needs to be installed"
  ./emacs-install.sh
fi

DOOM_BIN="$HOME/.config/emacs/bin"
if [[ ! -x "$DOOM_BIN/doom" ]]; then
  git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
fi

${DOOM_BIN}/doom install

# Detect default shell and corresponding RC file
user_shell="$(basename "$SHELL")"
case "$user_shell" in
    bash) SHELL_RC="$HOME/.bashrc" ;;
    zsh)  SHELL_RC="$HOME/.zshrc" ;;
    fish) SHELL_RC="$HOME/.config/fish/config.fish" ;;
    *)    echo "Unsupported shell: $user_shell. Add $DOOM_BIN to your PATH manually."; exit 1 ;;
esac

echo "Detected shell: $user_shell"
echo "Using shell config file: $SHELL_RC"

# Check and append to PATH if not already present
if ! grep -q "$DOOM_BIN" "$SHELL_RC"; then
    echo "Adding $DOOM_BIN to PATH in $SHELL_RC"
    case "$user_shell" in
        fish)
            echo -e "\n# Add Doom Emacs to PATH\nset -gx PATH $DOOM_BIN \$PATH" >> "$SHELL_RC"
            ;;
        *)
            echo -e "\n# Add Doom Emacs to PATH\nexport PATH=\"$DOOM_BIN:\$PATH\"" >> "$SHELL_RC"
            ;;
    esac
else
    echo "$DOOM_BIN already in PATH configuration."
fi

echo "Doom Emacs setup complete."
echo "You may want to restart your shell or run: source $SHELL_RC"
