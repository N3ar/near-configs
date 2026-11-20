#!/bin/bash

source ENV.sh
source HELPERS.sh

if command -v codex > /dev/null 2>&1; then
    notify w "Codex is already installed."
    exit 2
fi

if command -v npm > /dev/null 2>&1; then
    notify i "Prefer the npm installer for built in upgrades."
    npm install -g @openai/codex
    exit 0
fi

notify i "npm not present, installing standalone."
curl -fsSL https://chatgpt.com/codex/install.sh | sh
exit 0
