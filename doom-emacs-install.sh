#!/bin/bash

set -e

echo "Updating package list..."
sudo apt update -y

echo "Installing Doom Emacs Prereqs per Github Install Instructions..."
sudo apt install -y git ripgrep findutils fd-find

./emacs-install.sh

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

DOOM_BIN="$HOME/.config/emacs/bin"

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
if ! grep -q "$DOOM_BIN" "$shell_rc"; then
    echo "Adding $DOOM_BIN to PATH in $shell_rc"
    case "$user_shell" in
        fish)
            echo -e "\n# Add Doom Emacs to PATH\nset -gx PATH $DOOM_BIN \$PATH" >> "$shell_rc"
            ;;
        *)
            echo -e "\n# Add Doom Emacs to PATH\nexport PATH=\"$DOOM_BIN:\$PATH\"" >> "$shell_rc"
            ;;
    esac
else
    echo "$DOOM_BIN already in PATH configuration."
fi

echo "Reloading shell config..."
case "$user_shell" in
    bash|zsh)
        # shellcheck source=/dev/null
        source "$shell_rc"
        ;;
    fish)
        exec fish -c 'source ~/.config/fish/config.fish'
        ;;
esac

echo "Running Doom Emacs setup commands..."

# Ensure we are in ~/.config/emacs
pushd "$HOME/.config/emacs"

# Create bin link if missing (sometimes needed if user forgets)
if [[ ! -x "$DOOM_BIN/doom" ]]; then
    echo "Doom binary not found. Running 'doom install' first..."
    ./bin/doom install
fi

echo "Running 'doom sync'..."
"$DOOM_BIN/doom" sync

echo "Dumping environment with 'doom env'..."
"$DOOM_BIN/doom" env

echo "Checking configuration health with 'doom doctor'..."
"$DOOM_BIN/doom" doctor || true

echo "Doom Emacs setup complete."
echo "You may want to restart your shell or run: source $SHELL_RC"
