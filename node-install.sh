#!/bin/bash

# install volta if needed
if ! command -v volta > /dev/null 2>&1; then
    ./volta-install.sh
    echo "Re-run this command in the new terminal to install node"
fi

# Update shell after volta install
volta install node            # installs a recent Node + npm
