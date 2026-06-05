#!/bin/bash

if command -v nvm 2>&1 > /dev/null; then
    echo "nvm already installed"
    exit 0
fi

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# TODO fix command not found
nvm install --lts
nvm use --lts
