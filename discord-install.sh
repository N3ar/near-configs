#!/bin/bash
set -e

# Configuration
DISCORD_URL="https://discord.com/api/download?platform=linux&format=deb"
DOWNLOAD_DIR="/tmp"

# Create download directory
mkdir -p "$DOWNLOAD_DIR"

# Functions
install_discord() {
  pushd /tmp
  echo "[*] Downloading Discord .deb package..."
  DEB_FILE=$(wget --content-disposition --quiet --show-progress "$DISCORD_URL" 2>&1 \
    | grep -oP 'Saving to: ‘\K[^’]+' || true)
  
  echo "[*] Installing Discord..."
  DEB_NAME=`sudo find . -name "discord*.deb"`
  sudo apt install -y "${DEB_NAME}"
  echo "[*] Installation complete."
  popd
}

update_discord() {
  echo "[*] Updating Discord..."
  install_discord
}

uninstall_discord() {
  echo "[*] Uninstalling Discord..."
  sudo apt remove -y discord || true
  sudo apt autoremove -y
  echo "[*] Discord removed."
}

# Argument handling
case "$1" in
  ""|"--install")
    install_discord
    ;;
  "--update")
    update_discord
    ;;
  "--uninstall")
    uninstall_discord
    ;;
  *)
    echo "Usage: $0 [--install|--update|--uninstall]"
    exit 1
    ;;
esac

