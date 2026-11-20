#!/bin/bash

source ENV.sh
source HELPERS.sh

if command -v claude > /dev/null 2>&1; then
  notify w "claude is already installed"
  notify i "update with 'claude update' and fix with 'claude doctor'"
  exit 0
fi 

notify i "installing claude..."
curl -fsSL https://claude.ai/install.sh | bash
notify i "Claude installed: `claude --version`"
exit 0
