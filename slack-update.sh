# slack-update.sh
#!/usr/bin/env bash
set -euo pipefail

# Just re-invoke the installer to grab & apply the latest .deb
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
exec "$SCRIPT_DIR/slack-install.sh"
