# slack-uninstall.sh
#!/usr/bin/env bash
set -euo pipefail

SUDO=$([ "$(id -u)" -ne 0 ] && echo sudo || echo)

echo "🗑️  Removing Slack desktop package…"
$SUDO apt-get remove --purge -y slack-desktop

echo "[*] Cleaning up orphaned deps…"
$SUDO apt-get autoremove -y

echo "✅ Slack has been uninstalled!"
