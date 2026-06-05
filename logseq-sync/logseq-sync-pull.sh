#!/usr/bin/env bash
set -euo pipefail

# logseq-sync-pull.sh
# Pull latest changes into the Logseq notes repository.
# Triggered by systemd on boot or daily at 02:15.

SYNC_DIR="${HOME}/Documents/notes"

log() {
    echo "[$(date --iso-8601=seconds)] logseq-sync-pull: $*"
}

if [[ ! -d "${SYNC_DIR}/.git" ]]; then
    log "${SYNC_DIR} is not a git repository — skipping"
    exit 0
fi

cd "${SYNC_DIR}"

# Fast-fail: nothing to pull
if git status --porcelain -uno -z | read -r -d '' -n 1; then
    log "Working tree dirty (uncommitted changes) — skipping pull to avoid conflicts"
else
    if git fetch --quiet 2>/dev/null; then
        # Check whether local is behind
        if [[ "$(git rev-parse HEAD)" != "$(git rev-parse @{upstream})" ]] 2>/dev/null; then
            log "Pulling latest changes..."
            git pull --ff-only
            log "Pull complete"
        else
            log "Already up to date"
        fi
    else
        log "Fetch failed — not pulling (offline or remote unreachable)"
    fi
fi
