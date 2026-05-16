#!/bin/bash

source ./HELPERS.sh
source ./ENV.sh

if is_installed hermes; then
    exit 0
fi

notify i "Installing Hermes agent..."
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
notify s "Hermes installed successfully"
