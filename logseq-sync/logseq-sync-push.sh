#!/usr/bin/env bash
set -euo pipefail

# logseq-sync-push.sh
# Push pending commits from the Logseq notes repository.
# Triggered by systemd on shutdown (special unit) or daily at 02:00.

SYNC_DIR="${HOME}/Documents/notes"

log() {
    echo "[$(date --iso-8601=seconds)] logseq-sync-push: $*"
}

if [[ ! -d "${SYNC_DIR}/.git" ]]; then
    log "${SYNC_DIR} is not a git repository — skipping"
    exit 0
fi

cd "${SYNC_DIR}"

# Fast-fail: nothing to push
if git status --porcelain -uno -z | read -r -d '' -n 1; then
    log "Working tree dirty (uncommitted changes) — skipping push to avoid partial push"
elif [[ -n "$(git cherry -v '@{upstream}' 2>/dev/null)" ]]; then
    log "Pushing pending commits..."
    git push
    log "Push complete"
else
    log "Already up to date"
fi
