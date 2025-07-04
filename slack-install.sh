#!/bin/bash
set -e

# 'debian' or 'ubuntu'
# TODO TMP disabled because the snap version wouldn't open
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
#if [[ ${DISTRO} == "ubuntu" ]]; then
#    echo "Ubuntu must install via SNAP for some reason"
#    sudo snap install slack --classic
#    exit 0
#fi

########
### This is a forced debian install, not sure if it works with the above content
########
# Use sudo if not root
SUDO=$([ "$(id -u)" -ne 0 ] && echo sudo || echo)

# 1. Scrape Slack's Linux download page for the real .deb link
DOWNLOAD_PAGE="https://slack.com/downloads/instructions/linux?ddl=1&build=deb"
echo "[*] Fetching download URL from $DOWNLOAD_PAGE…"
DEB_URL=$(
  curl -sSL "$DOWNLOAD_PAGE" \
    | grep -Eo 'https://downloads\.slack-edge\.com/desktop-releases/linux/x64/[0-9]+\.[0-9]+\.[0-9]+/slack-desktop-[0-9]+\.[0-9]+\.[0-9]+-amd64\.deb' \
    | head -n1
)
if [[ -z "$DEB_URL" ]]; then
  echo "[!] Failed to locate .deb URL on download page." >&2
  exit 1
fi
echo "[*] Found package: $DEB_URL"

# 2. Download into a temp file
TMP_DEB=$(mktemp --suffix=.deb)
cleanup() { rm -f "$TMP_DEB"; }
trap cleanup EXIT

echo "[*]  Downloading Slack package…"
curl -sSL "$DEB_URL" -o "$TMP_DEB"

# 3. Install
echo "[*] Installing Slack…"
$SUDO dpkg -i "$TMP_DEB"

# 4. Fix any missing dependencies
echo "[*] Resolving dependencies…"
$SUDO apt-get update -qq
$SUDO apt-get install -f -y

echo "[+] Slack installed!"
